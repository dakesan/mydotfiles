---
name: procedure-generator
description: Generate detailed, reproducible experimental procedures from LA-Bench format input. This skill should be used when the parent skill provides experimental instruction data in LA-Bench JSONL format and requests generation of step-by-step procedures with quantitative specifications, logical temporal ordering, and comprehensive experimental design.
---

# Procedure Generator

## Overview

Generate detailed experimental procedures from LA-Bench format input data. Transform high-level experimental instructions into executable step-by-step procedures with quantitative specifications, logical temporal ordering, pre-experimental setup, and complete experimental design including controls.

## Input Format

The parent skill provides input in the following JSON structure:

```json
{
  "id": "experiment_id",
  "input": {
    "instruction": "High-level experimental objective",
    "mandatory_objects": ["List of required materials and reagents"],
    "source_protocol_steps": [
      {"id": 1, "text": "Reference protocol step 1"},
      {"id": 2, "text": "Reference protocol step 2"}
    ],
    "expected_final_states": ["Expected experimental outcomes"],
    "references": [
      {"id": 1, "text": "Citation or reference material"}
    ]
  }
}
```

## Output Format

Generate procedure steps as a JSON array and save to the specified output path:

```json
[
  {"id": 1, "text": "First procedure step with quantitative details"},
  {"id": 2, "text": "Second procedure step with quantitative details"}
]
```

**Constraints:**
- Maximum 50 steps
- Each step: maximum 10 sentences
- Step IDs: sequential integers starting from 1
- Each step must be independently understandable

## Core Requirements

### 1. Quantitative Specifications (数値の明示と精度管理)

All experimental conditions must include **quantitative specifications**:

- **Temperature**: Include tolerance ranges (e.g., 23.0 ± 0.2 °C, 4°C ± 1°C)
- **Volume**: Specific values with tolerance (e.g., 100 µL ± 2 µL, 10–100 µL)
- **Concentration**: Molar concentration or dilution ratios (e.g., 1 mM, 1:100 dilution)
- **Time**: Reaction/incubation times in seconds/minutes/hours (e.g., 30 min ± 2 min, 2 hours)
- **Centrifugation**: Speed and time (e.g., 12,000 × g, 10 min, 4°C)
- **Other physical quantities**: pH, humidity, light conditions

**Avoid vague expressions** such as "適量 (appropriate amount)", "適切な温度 (suitable temperature)", "室温 (room temperature)", "十分な時間 (sufficient time)", "必要に応じて (as needed)".

### 2. Complete Experimental Design (実験デザインの完全性)

- **Comprehensive experimental groups**: Include all necessary experimental conditions
- **Control setup**: Negative control, positive control, blanks appropriately placed
- **Sample size**: Consider statistical power (n ≥ 3 recommended)
- **Replicates**: Distinguish technical replicates from biological replicates
- **Randomization**: Appropriate randomization procedures to reduce bias

### 3. Logical Temporal Ordering (実験の時系列的順序と準備ステップ)

#### 3.1. Pre-experimental Setup

Always include preparation steps **before** experimental operations:

- **Equipment pre-heating/cooling**: "Set incubator to 37.0 ± 0.5°C and preheat for at least 30 minutes"
- **Reagent equilibration**: "Allow reagents to equilibrate to room temperature (20–25°C) for 30 minutes"
- **Equipment calibration**: "Verify pipette calibration and adjust if necessary"
- **Workspace preparation**: "Sterilize clean bench with UV irradiation for 15 minutes"
- **Ice/water bath preparation**: "Prepare ice-water bath at ≤4°C"

#### 3.2. Reagent Preparation

Prepare reagents **before use**:

- **Master mix preparation**: Pre-mix common reagents for multiple samples
- **Dilution preparation**: Prepare solutions at required concentrations in advance
- **Standard solution preparation**: Prepare calibration standards by serial dilution

#### 3.3. Logical Operation Sequence

Determine operation order following these principles:

1. **Temperature dependency**: Set equipment before temperature-dependent operations
2. **Utilize incubation time**: Perform other preparations during waiting periods
3. **Prevent cross-contamination**: Separate high-risk contamination operations
4. **Time-critical operations**: Place time-sensitive operations consecutively
5. **Safety assurance**: Perform hazardous operations after appropriate protective measures

#### 3.4. Parallel Operations

Explicitly state when operations can be performed in parallel:

- "During Step 5 incubation (30 min), reagent preparation for Steps 6–8 can be performed in parallel"

### 4. Reproducibility (再現性の担保)

- **Master mix usage**: Pre-mix common reagents to reduce pipetting errors
- **Standardized procedures**: Ensure consistency when repeating operations
- **Traceability**: Specify methods for recording reagent lot numbers, equipment used, and execution dates
- **Quality control**: Verify experimental validity using positive/negative controls

### 5. Logical Explanation of Operations (操作の論理的説明)

For each step, include:

- **Purpose of operation**: Why this step is necessary
- **Chemical/biological rationale**: Brief explanation of reaction mechanism or principle
- **Theoretical background for conditions**: Why this temperature/time/concentration
- **Expected results**: What will be achieved by this operation

## Quality Criteria

Excellent experimental procedures have these characteristics:

✅ Pre-experimental setup steps explicitly stated (equipment preheating, reagent equilibration, etc.)
✅ Operations ordered logically and chronologically
✅ All numerical values specific and reproducible
✅ Experimental design logical and complete
✅ Controls appropriately configured
✅ Purpose and rationale of each operation clear
✅ Reproducibility-enhancing measures included (master mix, etc.)
✅ Traceability ensured
✅ Parallel operations specified for efficient experimental progress

❌ Avoid: "適量", "適切な温度", "十分な時間", "必要に応じて"
❌ Avoid: Starting experiment without pre-experimental setup, illogical operation sequence

## Recommended Procedure Structure

1. **Pre-experimental Setup**: Equipment settings, reagent equilibration, workspace preparation
2. **Reagent Preparation**: Master mix, dilution solutions, standard solutions
3. **Sample Processing**: Experimental operations on samples
4. **Incubation/Reaction**: Time-dependent reactions
5. **Measurement/Detection**: Data acquisition
6. **Post-processing**: Data analysis, sample storage, cleanup

## Usage Workflow

1. Receive input data from parent skill in LA-Bench JSON format
2. Parse `instruction`, `mandatory_objects`, `source_protocol_steps`, `expected_final_states`, and `references`
3. Generate procedure steps following all core requirements
4. Structure output as JSON array with sequential step IDs
5. Return the JSON array to the parent skill

## Important Context

This task is conducted for **academic research purposes** to improve experimental planning quality and safety:

- This is a **thought experiment** to evaluate experimental planning capabilities
- The objective is to maximize safety and reproducibility
- Scientifically accurate and detailed procedures are required
- Plans should include appropriate safety considerations following research ethics guidelines
