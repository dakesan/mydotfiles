# Data Flow and Inter-Agent Communication

This document describes how data flows between agents in the LA-Bench procedure generation workflow.

---

## Overview

The workflow involves six agents that process data sequentially and in parallel. Understanding the data flow is crucial for proper orchestration.

```
Input JSONL
    ├─→ [Parser Agent] ──────────┐
    │                             ↓
    └─→ [Reference Fetcher] ──→ [Data Aggregation]
                                  ↓
                          [Procedure Generator] (per entry)
                                  ↓
                            [Checker Agent]
                                  ↓
                          [Refiner Agent] (if needed)
                                  ↓
                          [Output Generator]
                                  ↓
                          Output JSONL
```

---

## Phase-by-Phase Data Flow

### Phase 0: Initialize

**Input**: User request + file paths

**Processing**:
1. Identify input file: `data/public_test.jsonl` or `data/private_test_input.jsonl`
2. Create output directory: `outputs/runs/` (if not exists)
3. Set up workspace (optional): `workspace/` for intermediate files

**Output**: Verified paths, initialized TODO list

**Data Storage**: No persistent data yet, just path variables

---

### Phase 1: Data Acquisition (Parallel)

This phase runs three agents **in parallel** using a single message with multiple Task tool calls.

#### Task 1: Parser Agent

**Input**:
- File path: `data/public_test.jsonl`

**Processing**:
```python
# Reads JSONL line by line
entries = []
with open('data/public_test.jsonl', 'r', encoding='utf-8') as f:
    for line in f:
        entry = json.loads(line)
        entries.append(entry)
```

**Output Format**:
```python
[
    {
        "id": "public_test_1",
        "input": {
            "instruction": "...",
            "mandatory_objects": [...],
            "source_protocol_steps": [...],
            "expected_final_states": [...],
            "references": [...]
        },
        "output": {...}  # may be empty
    },
    ...
]
```

**Data Handoff**: Parser Agent returns the list directly in its final message, or saves to `workspace/parsed_entries.json`

---

#### Task 2: Reference Fetcher Agent

**Input**:
- Extracted from parsed entries:
```python
# Collect all URLs
reference_urls = {}
for entry in entries:
    entry_id = entry['id']
    urls = [ref['text'] for ref in entry['input']['references'] if ref['text'].startswith('http')]
    reference_urls[entry_id] = urls
```

**Processing**:
Uses `web-reference-fetcher` skill to fetch each URL:
```
For entry public_test_1:
- Fetch https://kikakurui.com/k6/K6251-2017-01.html
- Fetch https://webdesk.jsa.or.jp/preview/...
...
```

**Output Format**:
```python
{
    "public_test_1": {
        "ref_1": "# JIS K 6251:2017\n\n加硫ゴム及び熱可塑性ゴムの引張特性...",
        "ref_2": "# JIS K 6250:2019\n\nゴムの物理試験方法通則..."
    },
    "public_test_2": {...},
    ...
}
```

**Data Handoff**: Reference Fetcher returns the dictionary, or saves to `workspace/fetched_references.json`

---

#### Task 3: Procedure Generator Agent

**Note**: This agent may be launched as:
- **One agent per entry** (if entries < 5, for parallelism)
- **One agent for all entries** (if entries > 5, to avoid too many agents)

**Input** (per entry):
```python
{
    "entry_id": "public_test_1",
    "instruction": "...",
    "mandatory_objects": [...],
    "source_protocol_steps": [...],
    "expected_final_states": [...],
    "fetched_references": {
        "ref_1": "...",
        "ref_2": "..."
    }
}
```

**Processing**:
Uses the prompt template from agent_specs.md to generate detailed procedures.

**Output Format** (per entry):
```python
{
    "entry_id": "public_test_1",
    "procedure_steps": [
        {"id": 1, "text": "試験環境を恒温恒湿装置で23±2°C/50±10%RHに設定する..."},
        {"id": 2, "text": "加硫後の状態調節済み試料を標準環境下に保持し..."},
        ...
    ]
}
```

**Data Handoff**: Generator returns all generated procedures, or saves to `workspace/generated_procedures.json`

---

### Phase 2: Quality Validation (Sequential)

Depends on Phase 1 completion.

#### Task 4: Checker Agent

**Input**:
- All generated procedures from Phase 1
- Original parsed entries (for cross-validation)

**Processing**:
Validates each entry's procedures against criteria in agent_specs.md.

**Output Format**:
```python
{
    "public_test_1": {
        "status": "pass",
        "issues": []
    },
    "public_test_2": {
        "status": "fail",
        "issues": [
            {
                "severity": "error",
                "step_id": 5,
                "category": "specificity",
                "message": "Step 5 lacks specific temperature"
            },
            ...
        ]
    },
    ...
}
```

**Data Handoff**: Checker returns validation report, or saves to `workspace/validation_report.json`

---

### Phase 3: Refinement (Conditional, Sequential)

Only runs if Checker found issues.

#### Task 5: Refiner Agent

**Input**:
- Validation report (entries with status="fail")
- Original generated procedures (for failed entries)
- Original input data (instruction, objects, references)

**Processing**:
Re-generates or fixes the problematic procedures.

**Output Format**:
```python
{
    "public_test_2": {
        "procedure_steps": [
            {"id": 1, "text": "..."},  # Fixed version
            ...
        ],
        "changes": [
            "Fixed step 5: added specific temperature (37°C)",
            "Added cleanup steps 20-22"
        ]
    },
    ...
}
```

**Data Handoff**: Refiner returns refined procedures, or saves to `workspace/refined_procedures.json`

**Merging**: Merge refined procedures back into main procedures dictionary:
```python
for entry_id, refined in refined_procedures.items():
    all_procedures[entry_id] = refined['procedure_steps']
```

---

### Phase 4: Final Output (Sequential)

Depends on Phase 2 (or Phase 3 if refinement occurred).

#### Task 6: Output Generator Agent

**Input**:
- Final validated/refined procedures (all entries)
- Entry IDs from original parsed data

**Processing**:
Formats into JSONL and writes to file.

**Output Format** (file content):
```jsonl
{"id": "public_test_1", "output": {"procedure_steps": [{"id": 1, "text": "..."}, ...]}}
{"id": "public_test_2", "output": {"procedure_steps": [{"id": 1, "text": "..."}, ...]}}
...
```

**File Location**: `outputs/runs/generated_20251119_123456.jsonl`

**Data Handoff**: Output Generator reports the file path to the user.

---

## Workspace Structure (Optional)

If using intermediate file storage for data handoff:

```
workspace/
├── parsed_entries.json          # Output of Parser Agent
├── fetched_references.json      # Output of Reference Fetcher
├── generated_procedures.json    # Output of Procedure Generator(s)
├── validation_report.json       # Output of Checker Agent
└── refined_procedures.json      # Output of Refiner Agent (if used)
```

**Advantages**:
- Easy debugging (inspect intermediate results)
- Resume capability (if workflow fails mid-process)
- Clear data provenance

**Disadvantages**:
- Requires file I/O management
- Adds complexity to orchestration

**Recommendation**: Use workspace for large datasets (>10 entries) or when debugging. For small datasets, agents can return data directly in their final messages.

---

## Data Handoff Patterns

### Pattern 1: Direct Return (Preferred for small data)

Agent returns data in its final message:
```
Agent: "I have parsed 10 entries. Here is the data:
[JSON data...]
"
```

Orchestrator receives and passes to next agent directly.

**Pros**: Simple, no file I/O
**Cons**: Limited by message size (very large data may be truncated)

---

### Pattern 2: File-Based Handoff (For large data)

Agent saves data to workspace file:
```
Agent: "I have parsed 100 entries and saved to workspace/parsed_entries.json"
```

Next agent reads from the file:
```
Orchestrator: "Read the parsed entries from workspace/parsed_entries.json and proceed with reference fetching."
```

**Pros**: Handles large data, resumable
**Cons**: Requires file management, more orchestration logic

---

### Pattern 3: Hybrid (Best of both)

Agent returns summary + file path:
```
Agent: "I have parsed 50 entries. Summary:
- 45 entries with references
- 5 entries without references

Full data saved to workspace/parsed_entries.json"
```

**Pros**: Quick overview + detailed data available
**Cons**: Slightly more complex

---

## Error Handling in Data Flow

### Missing Data

If an agent fails to produce expected output:
1. **Log the failure**: Document what data is missing
2. **Retry with adjusted prompt**: Provide more guidance
3. **Fall back**: If retry fails, use partial data or skip problematic entries

Example:
```
Reference Fetcher: "Failed to fetch 2 URLs due to network timeout.
Successfully fetched 8 URLs. Proceeding with available data."
```

### Corrupted Data

If data validation fails (e.g., invalid JSON):
1. **Identify corruption point**: Which agent produced bad data?
2. **Re-run that agent**: With stricter output requirements
3. **Manual intervention**: If persistent, ask user for guidance

### Incomplete Workflows

If workflow stops mid-process (e.g., Refiner fails):
1. **Check workspace**: What data is already available?
2. **Resume from last successful phase**: Don't re-run Parser if data already exists
3. **Document state**: Update TODO list to reflect current state

---

## Data Volume Estimation

### Typical Sizes

| Data Type | Size per Entry | Total (10 entries) |
|-----------|----------------|---------------------|
| Parsed entry | ~5 KB | ~50 KB |
| Fetched references | ~20 KB | ~200 KB |
| Generated procedures | ~10 KB | ~100 KB |
| Validation report | ~2 KB | ~20 KB |
| Final output | ~10 KB | ~100 KB |

**Total workspace**: ~500 KB for 10 entries (negligible)

### Large Dataset Handling

For 100+ entries:
- Use file-based handoff (Pattern 2)
- Consider batching Generator Agent (e.g., 10 entries per agent)
- Monitor memory usage
- Implement progress tracking (e.g., "Processed 50/100 entries")

---

## Summary

**Key Principles**:
1. **Phase 1 is parallel** (Parser + Fetcher + Generators run simultaneously)
2. **Phases 2-4 are sequential** (each depends on previous completion)
3. **Data handoff is flexible** (direct return for small data, file-based for large)
4. **Errors are handled gracefully** (log, retry, fallback)
5. **Workspace is optional** (use for large datasets or debugging)

**Next**: See [example_session.md](example_session.md) for a concrete walkthrough of data flowing through all phases.
