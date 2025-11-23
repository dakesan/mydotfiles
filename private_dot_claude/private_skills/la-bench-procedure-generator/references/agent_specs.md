# Agent Specifications

This document provides detailed specifications for each subagent in the LA-Bench procedure generation workflow.

---

## Parser Agent

### Role
Parse JSONL input files and extract all entries with their complete data structure.

### Input
- **File path**: Path to JSONL file (e.g., `data/public_test.jsonl`)

### Output
- **Format**: Python list or JSON array
- **Structure**: List of dictionaries, each containing:
  ```json
  {
    "id": "public_test_1",
    "input": {
      "instruction": "...",
      "mandatory_objects": [...],
      "source_protocol_steps": [...],
      "expected_final_states": [...],
      "references": [...]
    },
    "output": {
      "procedure_steps": [...]  // may be empty for input-only files
    }
  }
  ```

### Implementation Guidelines

**Recommended approach**: Use Pydantic for type-safe parsing

```python
from pydantic import BaseModel
from typing import List, Optional
import json

class Reference(BaseModel):
    id: int
    text: str

class SourceProtocolStep(BaseModel):
    id: int
    text: str

class InputData(BaseModel):
    instruction: str
    mandatory_objects: List[str]
    source_protocol_steps: List[SourceProtocolStep]
    expected_final_states: List[str]
    references: List[Reference]

class ProcedureStep(BaseModel):
    id: int
    text: str

class OutputData(BaseModel):
    procedure_steps: List[ProcedureStep]

class Entry(BaseModel):
    id: str
    input: InputData
    output: Optional[OutputData] = None

# Parse JSONL
entries = []
with open('data/public_test.jsonl', 'r', encoding='utf-8') as f:
    for line in f:
        entry = Entry.model_validate_json(line)
        entries.append(entry)
```

### Success Criteria
- All entries successfully parsed without errors
- No data loss or corruption
- Valid UTF-8 encoding handling (Japanese text)
- Empty or missing fields handled gracefully

---

## Reference Fetcher Agent

### Role
Fetch content from reference URLs using the web-reference-fetcher skill.

### Input
- **All reference URLs** extracted from all entries
- Format: List of `{id: str, entry_id: str, url: str}` objects

### Output
- **Format**: Dictionary mapping entry_id to fetched content
- **Structure**:
  ```json
  {
    "public_test_1": {
      "reference_1": "fetched content from URL 1...",
      "reference_2": "fetched content from URL 2..."
    },
    "public_test_2": {...}
  }
  ```

### Implementation Guidelines

**Use web-reference-fetcher skill**:
```
Use the web-reference-fetcher skill to fetch the following URLs:
- Entry public_test_1, reference 1: https://example.com/protocol1
- Entry public_test_1, reference 2: https://example.com/protocol2
...

Store the results indexed by entry_id and reference_id.
```

**Fallback strategy**:
- If web-reference-fetcher is unavailable, use WebFetch tool directly
- Cache results to avoid redundant fetches
- Handle fetch failures gracefully (log and continue with available references)

### Success Criteria
- All accessible URLs successfully fetched
- Failed fetches logged with error messages
- Results properly indexed for easy lookup during generation
- No blocking on single URL failure

---

## Procedure Generator Agent

### Role
Generate detailed, step-by-step experimental procedures from input data and fetched references.

### Input (per entry)
- **instruction**: Natural language experimental goal
- **mandatory_objects**: List of available equipment/materials
- **source_protocol_steps**: High-level reference steps
- **expected_final_states**: Expected outcomes
- **fetched_references**: Detailed protocol information from URLs

### Output
- **Format**: List of procedure steps
- **Structure**:
  ```json
  {
    "procedure_steps": [
      {"id": 1, "text": "試験環境を恒温恒湿装置で23±2°C/50±10%RHに設定する..."},
      {"id": 2, "text": "加硫後の状態調節済み試料を標準環境下に保持し..."},
      ...
    ]
  }
  ```

### Generation Guidelines

#### Quality Criteria
1. **Completeness**: All steps from initial setup to final cleanup
2. **Specificity**: Exact quantities, temperatures, times, equipment settings
3. **Safety**: Include safety precautions (PPE, ventilation, waste disposal)
4. **Reproducibility**: Sufficient detail for independent replication
5. **Logical Order**: Steps follow physical/temporal dependencies
6. **Language**: Professional Japanese scientific writing

#### Prompt Template
```
あなたは経験豊富な実験プロトコル作成の専門家です。以下の情報から、再現性の高い詳細な実験手順を生成してください。

## 実験指示
{instruction}

## 使用可能な物品・機器
{mandatory_objects (bulleted list)}

## 参考手順（概要）
{source_protocol_steps (numbered list)}

## 期待される最終状態
{expected_final_states (bulleted list)}

## 参考文献の詳細情報
{fetched_references (formatted)}

---

以下の基準を満たす詳細な手順を生成してください：

1. **具体性**: 数値（体積、温度、時間、速度など）を明記
2. **完全性**: 準備・実行・後処理・記録まで全工程を含む
3. **安全性**: 保護具、換気、廃棄物処理などの注意事項
4. **論理性**: 手順の依存関係を考慮した順序
5. **再現性**: 第三者が独立して実施できる詳細度

出力形式：
JSON配列として、各ステップを {"id": 番号, "text": "手順の詳細..."} の形式で出力してください。
```

#### Common Pitfalls to Avoid
- ❌ Vague instructions ("適量を加える" → ✅ "10 mLを加える")
- ❌ Missing environmental conditions (温度・湿度・時間の記載漏れ)
- ❌ Skipped preparation steps (機器の校正、試薬の前処理など)
- ❌ Incomplete cleanup (廃棄物処理、機器の洗浄など)
- ❌ Ambiguous timing ("しばらく" → ✅ "15分間")

### Success Criteria
- All entries have generated procedure_steps
- Each procedure contains 15-30 detailed steps (typical range)
- Steps include specific numerical values where applicable
- Safety and quality checks are included
- Output is valid JSON format

---

## Checker Agent

### Role
Validate generated procedures against quality criteria and output format requirements.

### Input
- **All generated procedure_steps** (indexed by entry_id)
- **Original input data** (for cross-reference validation)

### Output
- **Validation report**: Dictionary of issues per entry
- **Structure**:
  ```json
  {
    "public_test_1": {
      "status": "pass",
      "issues": []
    },
    "public_test_3": {
      "status": "fail",
      "issues": [
        {
          "severity": "error",
          "step_id": 5,
          "category": "specificity",
          "message": "Step 5 lacks specific temperature: '適温' should be replaced with exact value"
        },
        {
          "severity": "warning",
          "step_id": null,
          "category": "completeness",
          "message": "No cleanup/disposal steps found"
        }
      ]
    }
  }
  ```

### Validation Checks

#### 1. Format Compliance
- ✅ Output is valid JSON
- ✅ Each step has `id` (integer) and `text` (string)
- ✅ Step IDs are sequential starting from 1
- ✅ No duplicate step IDs

#### 2. Completeness
- ✅ Minimum 10 steps (most protocols require 15-30)
- ✅ Includes preparation phase (setup, calibration, material prep)
- ✅ Includes execution phase (main experimental operations)
- ✅ Includes cleanup phase (waste disposal, equipment cleaning)
- ✅ Includes data recording/reporting steps

#### 3. Specificity
- ✅ Numerical values present where expected (volumes, temps, times)
- ✅ No vague terms: "適量", "しばらく", "適当に", "十分に" without quantification
- ✅ Equipment settings specified (speed, temperature, pressure, etc.)
- ✅ Reagent concentrations and volumes specified

#### 4. Logical Consistency
- ✅ Steps follow temporal/physical dependencies
- ✅ No contradictions (e.g., "heat to 100°C" then "place on ice" immediately)
- ✅ Mandatory objects are actually used in procedures
- ✅ Expected final states are achievable by the procedures

#### 5. Safety & Best Practices
- ✅ Safety equipment mentioned (goggles, gloves, fume hood)
- ✅ Hazardous materials handled appropriately
- ✅ Waste disposal procedures included
- ✅ Quality control checks present

### Severity Levels
- **error**: Must be fixed (blocks output generation)
- **warning**: Should be fixed (but not blocking)
- **info**: Minor suggestion (optional improvement)

### Success Criteria
- All entries have validation reports
- "error" issues are clearly documented with actionable fix suggestions
- At least 80% of entries pass validation on first attempt (target)

---

## Refiner Agent

### Role
Address validation issues by regenerating or fixing problematic procedure steps.

### Input
- **Validation report** from Checker Agent
- **Original generated procedures** (entries with issues)
- **Original input data** (instruction, objects, references, etc.)

### Output
- **Refined procedures**: Corrected procedure_steps for failed entries
- **Refinement report**: Summary of changes made

### Refinement Strategy

#### For Format Issues
- Regenerate the specific malformed steps
- Ensure JSON validity and schema compliance

#### For Completeness Issues
- Insert missing phases (preparation, cleanup, recording)
- Expand abbreviated steps into detailed sub-steps

#### For Specificity Issues
- Replace vague terms with concrete values
- Add missing numerical specifications
- Consult fetched references for standard values

#### For Logical Consistency Issues
- Reorder steps to respect dependencies
- Remove contradictions
- Verify all mandatory objects are utilized

#### For Safety Issues
- Add safety precautions and PPE requirements
- Include waste disposal steps
- Add quality control checkpoints

### Refinement Prompt Template
```
以下の実験手順に検証エラーが見つかりました。指摘された問題を修正してください。

## 元の手順
{original_procedure_steps}

## 検証レポート
{validation_issues (formatted)}

## 元の実験データ
- 指示: {instruction}
- 使用物品: {mandatory_objects}
- 参考手順: {source_protocol_steps}
- 参考文献: {fetched_references}

---

以下の点に注意して修正してください：
1. エラーレベルの問題は必ず修正
2. 警告レベルの問題も可能な限り対処
3. 元の手順の意図を保ちつつ、詳細度を向上
4. 全ての修正箇所を明確に記録

修正後の手順をJSON形式で出力してください。
```

### Success Criteria
- All "error" level issues resolved
- At least 90% of "warning" issues resolved
- Refined procedures pass Checker Agent validation
- No new issues introduced during refinement

---

## Output Generator Agent

### Role
Format all validated/refined procedures into final LA-Bench JSONL output format and save to file.

### Input
- **All validated procedure_steps** (final version after refinement)
- **Entry IDs** from original input

### Output
- **File**: `outputs/runs/generated_YYYYMMDD_HHMMSS.jsonl`
- **Format**: One JSON object per line (JSONL)
- **Structure** (each line):
  ```json
  {"id": "public_test_1", "output": {"procedure_steps": [{"id": 1, "text": "..."}, {"id": 2, "text": "..."}, ...]}}
  ```

### Implementation Guidelines

```python
import json
from datetime import datetime
from pathlib import Path

# Prepare output directory
output_dir = Path("outputs/runs")
output_dir.mkdir(parents=True, exist_ok=True)

# Generate timestamp
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
output_path = output_dir / f"generated_{timestamp}.jsonl"

# Write JSONL
with open(output_path, 'w', encoding='utf-8') as f:
    for entry_id, procedure_steps in validated_procedures.items():
        output_obj = {
            "id": entry_id,
            "output": {
                "procedure_steps": procedure_steps
            }
        }
        f.write(json.dumps(output_obj, ensure_ascii=False) + '\n')

print(f"Output saved to: {output_path}")
```

### Output Validation
Before finalizing, verify:
- ✅ File is valid JSONL (each line is valid JSON)
- ✅ All entry IDs from input are present in output
- ✅ No extra entries
- ✅ UTF-8 encoding (Japanese text preserved)
- ✅ Follows schema in `assets/output_schema.json`

### Success Criteria
- Output file successfully created
- File is readable and valid JSONL
- Entry count matches input file
- File size is reasonable (not empty, not corrupted)
- Path is logged for user reference

---

## Troubleshooting

### Common Agent Failures

**Parser Agent fails**:
- Check file encoding (should be UTF-8)
- Verify JSONL format (one JSON object per line)
- Look for malformed JSON in input file

**Reference Fetcher fails**:
- Check network connectivity
- Verify URLs are accessible
- Check if web-reference-fetcher skill is available

**Generator Agent produces low-quality output**:
- Verify fetched references contain useful information
- Check if prompt template needs refinement
- Consider providing more detailed examples in prompt

**Checker Agent reports too many errors**:
- Review quality criteria (may be too strict)
- Check if generator prompt needs improvement
- Verify validation logic is correct

**Refiner Agent fails to fix issues**:
- Provide more specific guidance in refinement prompt
- Break down refinement into smaller sub-tasks
- Consider manual review of particularly problematic entries

**Output Generator fails**:
- Check write permissions on output directory
- Verify disk space availability
- Check for very large procedure_steps (memory issues)
