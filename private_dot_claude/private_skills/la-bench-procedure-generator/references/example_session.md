# Example Session: Complete Workflow Walkthrough

This document provides a detailed example of a complete LA-Bench procedure generation session, showing how the orchestrator and agents interact.

---

## Scenario

**User Request**: "Process data/public_test.jsonl and generate detailed experimental procedures"

**Input File**: `data/public_test.jsonl` (contains 10 entries: public_test_1 through public_test_10)

---

## Phase 0: Initialize

### Orchestrator Actions

```
[Orchestrator uses TodoWrite tool]

TODO List Created:
1. [pending] Parse JSONL input file
2. [pending] Fetch reference URLs
3. [pending] Generate procedures for all entries
4. [pending] Validate generated procedures
5. [pending] Refine procedures if needed
6. [pending] Generate final output file

[Orchestrator verifies paths]

✓ Input file exists: data/public_test.jsonl
✓ Output directory created: outputs/runs/
✓ Workspace directory created: workspace/
```

**Output**: Initialized TODO list, verified file paths

---

## Phase 1: Data Acquisition (Parallel)

### Orchestrator Actions

```
[Orchestrator marks TODOs 1-3 as in_progress]

[Orchestrator launches 3 agents in parallel using single message with multiple Task tool calls]

Task 1: Parser Agent
Task 2: Reference Fetcher Agent
Task 3: Procedure Generator Agent (will process all 10 entries)
```

---

### Task 1: Parser Agent Execution

**Agent Report**:
```
✓ Successfully parsed 10 entries from data/public_test.jsonl

Summary:
- public_test_1: 引張試験 (6 source steps, 2 references)
- public_test_2: 粘度測定 (6 source steps, 1 reference)
- public_test_3: カフェイン抽出 (6 source steps, 2 references)
- public_test_4: RNA保管 (3 source steps, 1 reference)
- public_test_5 through 10: Various experiments

Full data saved to: workspace/parsed_entries.json
Total entries: 10
```

---

### Task 2: Reference Fetcher Agent Execution

**Agent Report**:
```
✓ Successfully fetched 6 reference URLs

Summary:
- Total URLs processed: 6
- Successful fetches: 6
- Failed fetches: 0

Fetched content saved to: workspace/fetched_references.json
```

---

### Task 3: Procedure Generator Agent Execution

**Agent Report**:
```
✓ Successfully generated procedures for all 10 entries

Summary:
- Average steps per entry: 21.8
- Total procedures generated: 10/10

Generated procedures saved to: workspace/generated_procedures.json
```

---

## Phase 2: Quality Validation

### Task 4: Checker Agent Execution

**Agent Report**:
```
✓ Validation complete for 10 entries

Summary:
- PASS: 9 entries
- FAIL: 1 entry (public_test_4)

Failed entries:
- public_test_4: Insufficient detail

Recommendation: Refine public_test_4
```

---

## Phase 3: Refinement

### Task 5: Refiner Agent Execution

**Agent Report**:
```
✓ Successfully refined public_test_4

Changes made:
- Expanded from 3 steps to 15 steps
- Added specific values and safety precautions

Refined procedure re-validated: PASS
```

---

## Phase 4: Final Output

### Task 6: Output Generator Agent Execution

**Agent Report**:
```
✓ Successfully generated final output file

Output details:
- File: outputs/runs/generated_20251119_143022.jsonl
- Entries: 10
- Total steps: 230
```

---

## Final Summary

```
✅ LA-Bench procedure generation complete!

Output: outputs/runs/generated_20251119_143022.jsonl
Total execution time: ~12 minutes
```
