# Bioinformatics Experiment Workflow Guide

Complete guide to using the bioinformatics-experiment skill from start to finish.

## Table of Contents
- [Overview](#overview)
- [Workflow 1: Experiment Planning](#workflow-1-experiment-planning)
- [Workflow 2: Experiment Clarification](#workflow-2-experiment-clarification)
- [Workflow 3: Experiment Execution & Updates](#workflow-3-experiment-execution--updates)
- [Workflow 4: Report Generation](#workflow-4-report-generation)
- [Complete Example](#complete-example)
- [Tips & Best Practices](#tips--best-practices)

---

## Overview

### The Four-Stage Workflow

```
┌─────────────────────────────────────────────────────────────────┐
│                    Bioinformatics Experiment                     │
│                         Life Cycle                               │
└─────────────────────────────────────────────────────────────────┘

    1. PLAN              2. CLARIFY           3. EXECUTE          4. REPORT
       ↓                     ↓                    ↓                   ↓
  ┌─────────┐          ┌─────────┐          ┌─────────┐         ┌─────────┐
  │ /exp-   │          │ /exp-   │          │ /exp-   │         │ /exp-   │
  │ plan    │   →      │ clarify │   →      │ update- │   →     │ report  │
  │         │          │         │          │ labnote │         │         │
  └─────────┘          └─────────┘          └─────────┘         └─────────┘
      │                     │                    │                   │
      ↓                     ↓                    ↓                   ↓
  Create Exp##         Resolve              Update with         Generate
  labnote with         ambiguities          commands &          analysis
  basic info           (max 5 Q&A)          results             report
      │                     │                    │                   │
      ↓                     ↓                    ↓                   ↓
  docs/markdown/       Add to                docs/markdown/      docs/markdown/
  Exp##_*.md          Clarifications        Exp##_*.md          Exp##_report.md
                      section               (updated)

┌──────────────────────────────────────────────────────────────────┐
│ Parallel Activities                                              │
├──────────────────────────────────────────────────────────────────┤
│ • Write analysis code (src/, scripts/)                           │
│ • Create Jupyter notebooks (docs/notebook/Exp##_*.ipynb)         │
│ • Run computational analysis                                     │
│ • Generate results (results/Exp##_*/)                            │
└──────────────────────────────────────────────────────────────────┘
```

### File Output Summary

| Workflow | Command | Output File | Purpose |
|----------|---------|-------------|---------|
| 1. Plan | `/exp-plan` | `docs/markdown/Exp##_description.md` | Experiment plan |
| 2. Clarify | `/exp-clarify` | Updates `Exp##_description.md` | Add clarifications |
| 3. Execute | `/exp-update-labnote` | Updates `Exp##_description.md` | Add execution logs |
| 4. Report | `/exp-report` | `docs/markdown/Exp##_report.md` | Analysis report |

---

## Workflow 1: Experiment Planning

### Trigger
User says: "Create a new experiment for [purpose]" or directly calls `/exp-plan`

### Steps

#### 1.1 Find Next Experiment Number
```bash
# AI automatically runs:
ls -1 docs/markdown/Exp*.md 2>/dev/null | grep -oP 'Exp\K\d+' | sort -n | tail -1

# If no experiments exist → Exp01
# If Exp03 exists → Exp04
```

#### 1.2 Gather Essential Information
AI asks minimal questions (4 questions max):

**Q1: Title/Description**
```
What's a brief title for this experiment?
(Use lowercase-with-hyphens format, e.g., "rna-seq-quality-control")
```

**Q2: Objective**
```
What do you want to accomplish? (1-2 sentences)
Example: "Assess RNA-seq data quality and identify samples requiring re-sequencing"
```

**Q3: Input Data**
```
Where is your input data located? (absolute path)
Example: /data/raw/rnaseq_samples/
```

**Q4: Output Location**
```
Where should results be saved? (default: results/Exp##_description)
Press Enter for default or specify custom path.
```

#### 1.3 Load Template
```bash
# AI reads template
~/.claude/skills/bioinformatics-experiment/assets/labnote.md
```

#### 1.4 Populate Template
AI replaces placeholders:
- `[EXP_NUMBER]` → 04 (zero-padded)
- `[TITLE]` → RNA-seq Quality Control
- `[DATE]` → 2025-11-01
- `[DESCRIPTION]` → rna-seq-quality-control
- `[OBJECTIVE]` → User's objective
- `[INPUT_PATH]` → /data/raw/rnaseq_samples/
- `[OUTPUT_PATH]` → results/Exp04_rna-seq-quality-control/

Leaves as placeholders:
- `[TOOL1]`, `[VERSION]` - to be filled during execution

#### 1.5 Write File
```bash
# AI creates:
docs/markdown/Exp04_rna-seq-quality-control.md
```

#### 1.6 Report Completion
```
✓ Experiment labnote created

File: docs/markdown/Exp04_rna-seq-quality-control.md
Experiment: Exp04
Title: RNA-seq Quality Control

Next steps:
- Run /exp-clarify to resolve ambiguities (recommended)
- Start working on the experiment
- Use /exp-update-labnote to track progress
```

### User Sees
A markdown file with structure:
```markdown
# Exp04: RNA-seq Quality Control

Date: 2025-11-01

## Objective
Assess RNA-seq data quality and identify samples requiring re-sequencing

## Tools & Versions
- [TOOL1]: [VERSION]

## Data
- Input: /data/raw/rnaseq_samples/
- Output: results/Exp04_rna-seq-quality-control/

## Trial 1 - [SUBTITLE]
### Plan
- [STEP1]
...
```

---

## Workflow 2: Experiment Clarification

### Trigger
User says: "Clarify Exp04" or calls `/exp-clarify Exp04`

### Purpose
**Prevent wasted computational resources** by ensuring:
- ✅ Absolute paths are specified
- ✅ Data formats are clear
- ✅ Success criteria are defined
- ✅ Tool choices are justified

### Steps

#### 2.1 Parse Experiment Number
```bash
# User input: "Clarify Exp04"
# AI extracts: Exp04
```

#### 2.2 Load Files
```bash
# AI reads:
1. docs/markdown/Exp04_*.md (labnote)
2. pyproject.toml (compute resources, if exists)
```

#### 2.3 Perform Coverage Scan
AI assesses 8 categories as **Clear** / **Partial** / **Missing**:

| Category | Assessment Criteria | Priority |
|----------|-------------------|----------|
| Experiment Objective | Specific, measurable goals? | Medium |
| Input Data | Absolute path? Format? Scale? | **HIGH** |
| Output Specification | Path? Format? Naming convention? | **HIGH** |
| Analysis Method | Tool justified? Parameters defined? | Medium |
| Success Criteria | Quantitative metrics? Pass/fail thresholds? | High |
| Compute Resources | Threads? Memory? Runtime estimate? | Medium |
| Edge Cases | Failure handling? Data validation? | Low |
| Biological Context | Hypothesis? Interpretation plan? | Low |

Example scan result:
```
Coverage Scan Results:
✓ Objective: Clear
✗ Input Data: Missing (no format specified)
△ Output Specification: Partial (path exists, format unclear)
△ Analysis Method: Partial (tools listed, parameters missing)
✗ Success Criteria: Missing
△ Compute Resources: Partial (using defaults)
✓ Edge Cases: Clear
△ Biological Context: Partial
```

#### 2.4 Generate Prioritized Questions (Max 5)

Priority order:
1. **Path specification** (input/output)
2. **Data format & scale**
3. **Success criteria**
4. **Tool/parameter rationale**
5. **Biological context**

Example questions:

**Q1 (Path):**
```
What is the exact format of your input data?

a) FASTQ files (paired-end, *.fastq.gz)
b) BAM files (aligned reads)
c) Count matrix (CSV/TSV)
d) Other (please specify)
```

**Q2 (Scale):**
```
How many samples are you analyzing?

[Short answer]
```

**Q3 (Success Criteria):**
```
What quality metrics will determine if a sample passes QC?

Example: "Q-score ≥20, mapping rate >80%, read count >10M"

[Short answer]
```

**Q4 (Tool Parameters):**
```
Which QC tool do you plan to use?

a) FastQC + MultiQC
b) Qualimap
c) RSeQC
d) Custom pipeline
```

**Q5 (Compute):**
```
Do you need to override default compute resources (90 cores, 358GB)?

a) Yes, I need more resources
b) Yes, I need fewer resources (specify: ___ cores, ___ GB)
c) No, defaults are fine
```

#### 2.5 Present Questions ONE at a Time

**Interactive Flow:**
```
User: /exp-clarify Exp04

AI: I've analyzed Exp04 and identified 5 areas needing clarification.

Question 1/5 - Input Data Format:
What is the exact format of your input data?

a) FASTQ files (paired-end, *.fastq.gz)
b) BAM files (aligned reads)
c) Count matrix (CSV/TSV)
d) Other (please specify)

User: a

AI: ✓ Recorded: FASTQ files (paired-end)

Question 2/5 - Sample Count:
How many samples are you analyzing?

User: 48 samples (24 tumor-normal pairs)

AI: ✓ Recorded: 48 samples (24 tumor-normal pairs)

[Continues through all 5 questions...]
```

#### 2.6 Update Labnote After EACH Answer

After each answer, AI immediately updates labnote:

```markdown
## Clarifications

### Input Data Specification (2025-11-01)
- **Format**: FASTQ files (paired-end, gzip compressed)
- **Naming pattern**: `*_R1.fastq.gz`, `*_R2.fastq.gz`
- **Sample count**: 48 samples (24 tumor-normal pairs)

### Success Criteria (2025-11-01)
- **Q-score**: ≥20 (phred quality)
- **Read count**: >10M reads per sample
- **Mapping rate**: >80%
- **Duplication rate**: <30%

### Compute Resources (2025-11-01)
- **Cores**: 90 (default, 70% of server capacity)
- **Memory**: 358GB (default)
- **Estimated runtime**: ~6 hours for 48 samples
```

Also replaces vague terms in existing sections:
- "quality data" → "Q-score ≥20"
- "sufficient coverage" → ">10M reads per sample"
- "some samples" → "48 samples (24 tumor-normal pairs)"

#### 2.7 Report Summary

```
✓ Clarification complete for Exp04

Questions answered: 5/5

Coverage improved:
  Input Data: Missing → Clear ✓
  Output Specification: Partial → Clear ✓
  Success Criteria: Missing → Clear ✓
  Analysis Method: Partial → Clear ✓
  Compute Resources: Partial → Clear ✓

Readiness Assessment: READY TO EXECUTE ✓

Updated file: docs/markdown/Exp04_rna-seq-quality-control.md

You can now start the experiment with confidence.
```

### User Sees
Updated labnote with new `## Clarifications` section and refined descriptions throughout.

---

## Workflow 3: Experiment Execution & Updates

### Trigger
User says: "I ran [command], update Exp04" or calls `/exp-update-labnote`

### Purpose
Track execution incrementally - record commands, results, and observations as you work.

### Steps

#### 3.1 Parse Experiment Number
```bash
# User: "Update Exp04 with FastQC results"
# AI extracts: Exp04
```

#### 3.2 Find and Read Labnote
```bash
# AI searches:
ls -1 docs/markdown/Exp04_*.md

# Reads:
docs/markdown/Exp04_rna-seq-quality-control.md
```

#### 3.3 Ask What to Add

```
What would you like to add to Exp04?

a) New process step (with command)
b) Results/observations
c) Issues encountered
d) Tool versions
```

#### 3.4 Gather Information (Example: New Process Step)

**AI asks:**
```
Step name/action:
> Run FastQC on all samples

Rationale (why this step/approach):
> FastQC provides comprehensive quality metrics including per-base quality, GC content, and adapter contamination

Complete command with all parameters:
> fastqc -t 16 -o results/Exp04_rna-seq-quality-control/fastqc/ /data/raw/rnaseq_samples/*.fastq.gz

Result (numbers, metrics, status):
> Completed in 2.5 hours. 46/48 samples passed quality thresholds (Q-score ≥20, >10M reads). 2 samples flagged for low read count (<8M reads).
```

#### 3.5 Append to Labnote

AI adds to `## Trial 1` → `### Methods` section:

```markdown
### Methods

#### Step 1: Run FastQC Quality Control

**Why**: FastQC provides comprehensive quality metrics including per-base quality, GC content, and adapter contamination

```bash
fastqc -t 16 \
  -o results/Exp04_rna-seq-quality-control/fastqc/ \
  /data/raw/rnaseq_samples/*.fastq.gz
```

**Parameters**:
- `-t 16`: Use 16 threads for parallel processing
- `-o`: Output directory for HTML reports

**Result**: Completed in 2.5 hours. 46/48 samples passed quality thresholds (Q-score ≥20, >10M reads). 2 samples flagged for low read count (<8M reads): sample_023_tumor, sample_041_normal.
```

#### 3.6 Save and Report

```
✓ Labnote updated

File: docs/markdown/Exp04_rna-seq-quality-control.md

Added:
- Step 1: Run FastQC Quality Control
  - Command with parameters
  - Results: 46/48 samples passed QC

Next: Continue updating labnote as you execute more steps.
```

### Usage Pattern

**Incremental updates during execution:**

```
User: Run FastQC
→ /exp-update-labnote

User: Run MultiQC to aggregate results
→ /exp-update-labnote

User: Identify low-quality samples
→ /exp-update-labnote

User: Re-sequence 2 failed samples
→ /exp-update-labnote
```

Each update adds to the labnote timeline.

---

## Workflow 4: Report Generation

### Trigger
User says: "Generate report for Exp04" or calls `/exp-report Exp04`

### Purpose
Create human-focused analysis report with interpretation and biological meaning.

### Steps

#### 4.1 Parse Experiment Range

```bash
# Single experiment:
/exp-report Exp04

# Multiple experiments:
/exp-report Exp01-Exp04
```

#### 4.2 Read Corresponding Labnotes

```bash
# AI reads:
docs/markdown/Exp04_rna-seq-quality-control.md

# Or for range (Exp01-04):
docs/markdown/Exp01_*.md
docs/markdown/Exp02_*.md
docs/markdown/Exp03_*.md
docs/markdown/Exp04_*.md
```

**AI extracts:**
- Objectives
- Methods used (all commands)
- Key findings (from Results sections)
- Tool versions
- Data paths
- Figures generated

#### 4.3 Ask for Report Details

```
Report title:
> RNA-seq Quality Control and Sample Selection

Main findings to highlight (3-5 bullet points):
> - 46/48 samples passed comprehensive QC (95.8% success rate)
> - 2 samples require re-sequencing due to low read count
> - Overall data quality exceeds project requirements
> - No systematic batch effects detected

Biological interpretations (optional, can fill later):
> [Leave blank for now - will add after reviewing figures]

Author name:
> Dr. Hiro Tanaka
```

#### 4.4 Load Template

```bash
# AI reads:
~/.claude/skills/bioinformatics-experiment/assets/report.md
```

#### 4.5 Populate Template

**Auto-filled from labnote:**
- `[TITLE]` → RNA-seq Quality Control and Sample Selection
- `[EXP_RANGE]` → Exp04
- `[DATE]` → 2025-11-01
- `[AUTHOR]` → Dr. Hiro Tanaka
- `[OBJECTIVE]` → Assess RNA-seq data quality and identify samples requiring re-sequencing
- `[DATA_DESCRIPTION]` → 48 paired-end FASTQ samples (24 tumor-normal pairs)
- `[STEP1]` → FastQC quality control (extracted from Methods)
- `[STEP2]` → MultiQC aggregation (extracted from Methods)
- `[TOOL1]` → FastQC: v0.12.1
- `[TOOL2]` → MultiQC: v1.14

**Left for human input:**
- `[INTERPRETATION]` - Why these results matter
- `[IMPLICATIONS]` - Biological implications
- `[SIGNIFICANCE_DISCUSSION]` - Discussion of findings
- `[CONCLUSIONS]` - Final conclusions

#### 4.6 Create File

```bash
# AI creates:
docs/markdown/Exp04_rna-seq-qc-report.md
```

#### 4.7 Report Completion

```
✓ Analysis report created

File: docs/markdown/Exp04_rna-seq-qc-report.md
Experiments covered: Exp04

Auto-filled sections:
- Objective
- Data description (48 samples, FASTQ format)
- Analysis pipeline (2 steps: FastQC, MultiQC)
- Software versions (FastQC v0.12.1, MultiQC v1.14)
- Labnote references

Sections to complete (HUMAN INPUT):
- Results interpretation
- Biological implications
- Discussion of findings
- Conclusions

This is for HUMANS - write clearly with thoughtful interpretation.

Next: Open the report file and complete the interpretation sections.
```

### User Sees

A report with structure:

```markdown
# RNA-seq Quality Control and Sample Selection

Experiments: Exp04
Date: 2025-11-01
Author: Dr. Hiro Tanaka

## Objective
Assess RNA-seq data quality and identify samples requiring re-sequencing

## Methods

### Data
48 paired-end FASTQ samples (24 tumor-normal pairs) [^1]

### Analysis Pipeline
1. FastQC quality control [^2]
2. MultiQC result aggregation [^3]

### Software Versions
- FastQC: v0.12.1 [^4]
- MultiQC: v1.14 [^4]

## Results

### [FINDING_TITLE]

[FINDINGS - AUTO-FILLED FROM LABNOTE] [^5]

![Figure 1: Quality Metrics](results/Exp04_*/quality_summary.png) [^6]

Interpretation: [FILL IN - WHY THIS MATTERS]

## Discussion

### Main Findings
- [Main finding 1 - AUTO-FILLED]
- [Main finding 2 - AUTO-FILLED]

[SIGNIFICANCE_DISCUSSION - FILL IN - WHAT THIS MEANS BIOLOGICALLY]

## Conclusions
- [FILL IN - HUMAN INTERPRETATION]

## References

### Experimental Data
[^1]: docs/markdown/Exp04_rna-seq-quality-control.md - Experiment labnote
[^2]: docs/markdown/Exp04_rna-seq-quality-control.md:L45 - FastQC command
[^3]: results/Exp04_rna-seq-quality-control/multiqc_report.html
...
```

**User then adds:**
- Interpretation of results
- Biological significance
- Discussion points
- Conclusions

---

## Complete Example

### Scenario: RNA-seq Quality Control

#### Day 1: Planning (5 minutes)

```
User: I need to run quality control on our new RNA-seq samples

AI: Let me help you create an experiment plan.

/exp-plan activated...

What's a brief title? (lowercase-with-hyphens)
User: rna-seq-quality-control

What do you want to accomplish?
User: Assess quality of 48 RNA-seq samples and identify any that need re-sequencing

Where is your input data?
User: /data/raw/rnaseq_batch2/

Output location? (default: results/Exp04_rna-seq-quality-control)
User: [Enter - use default]

✓ Experiment labnote created
File: docs/markdown/Exp04_rna-seq-quality-control.md

Next: Run /exp-clarify (recommended)
```

#### Day 1: Clarification (10 minutes)

```
User: /exp-clarify Exp04

AI: Coverage scan complete. I have 5 questions.

Q1/5 - Input Data Format:
What is the exact format?
a) FASTQ (paired-end)
b) FASTQ (single-end)
c) BAM
d) Other

User: a

✓ Recorded

Q2/5 - Sample Count:
How many samples?

User: 48 samples, 24 tumor-normal pairs

✓ Recorded

Q3/5 - Success Criteria:
What metrics determine QC pass/fail?

User: Q-score ≥20, >10M reads, mapping rate >80%, duplication <30%

✓ Recorded

Q4/5 - Analysis Tools:
Which QC tool?
a) FastQC + MultiQC
b) Qualimap
c) RSeQC

User: a

✓ Recorded

Q5/5 - Compute Resources:
Use default (90 cores, 358GB)?

User: Yes

✓ Clarification complete
Readiness: READY TO EXECUTE ✓

Updated: docs/markdown/Exp04_rna-seq-quality-control.md
```

#### Day 2: Execution (ongoing)

**Morning:**
```
User: I ran FastQC on all samples. Update Exp04.

AI: /exp-update-labnote activated

What to add?
a) New process step
b) Results
c) Issues
d) Tool versions

User: a

Step name:
User: Run FastQC quality control

Rationale:
User: Generate per-sample quality metrics

Command:
User: fastqc -t 16 -o results/Exp04_rna-seq-quality-control/fastqc/ /data/raw/rnaseq_batch2/*.fastq.gz

Result:
User: Completed in 2.5 hours. 46/48 passed. 2 samples low read count.

✓ Updated: docs/markdown/Exp04_rna-seq-quality-control.md
```

**Afternoon:**
```
User: I aggregated results with MultiQC. Update Exp04.

[Same flow, adds Step 2...]

✓ Updated
```

**Evening:**
```
User: Identified which samples failed. Update Exp04 with results.

[Adds results section...]

✓ Updated
```

#### Day 3: Reporting (30 minutes)

```
User: /exp-report Exp04

AI: Report Details:

Title:
User: RNA-seq QC and Sample Selection for Re-sequencing

Main findings:
User:
- 95.8% samples passed comprehensive QC
- 2 samples require re-sequencing (sample_023, sample_041)
- Overall quality excellent
- No batch effects

Author:
User: Dr. Hiro Tanaka

✓ Report created
File: docs/markdown/Exp04_rna-seq-qc-report.md

Auto-filled: Objective, Methods, Pipeline, Tool versions
To complete: Interpretation, Discussion, Conclusions

[User opens file and adds human interpretation...]
```

#### Final File Structure

```
docs/
├── markdown/
│   ├── Exp04_rna-seq-quality-control.md  ← Labnote (AI-readable)
│   └── Exp04_rna-seq-qc-report.md        ← Report (Human-readable)
└── notebook/
    └── Exp04_qc-plots.ipynb              ← Analysis (created separately)

results/
└── Exp04_rna-seq-quality-control/
    ├── fastqc/
    ├── multiqc_report.html
    └── quality_summary.png
```

---

## Tips & Best Practices

### 1. When to Use Each Workflow

| Situation | Command | Timing |
|-----------|---------|--------|
| Starting new analysis | `/exp-plan` | Beginning |
| Unclear requirements | `/exp-clarify` | After planning, before execution |
| Ran a command | `/exp-update-labnote` | Immediately after |
| Got results | `/exp-update-labnote` | When results ready |
| Experiment done | `/exp-report` | After all execution complete |

### 2. Clarification Tips

✅ **Do clarify when:**
- Working with large datasets (>100GB)
- Using expensive compute (GPU, HPC)
- Paths are unclear
- Tool choice uncertain
- Success criteria undefined

❌ **Skip clarification when:**
- Quick exploratory analysis
- Well-defined pipeline (done before)
- All details already in plan

### 3. Update Frequency

**Good:**
```
✓ Update after each major step
✓ Update when results change your approach
✓ Update when encountering issues
```

**Bad:**
```
✗ Wait until end to update everything
✗ Update every tiny command
✗ Skip updates "to save time"
```

### 4. Report Timing

**Best time to generate report:**
- ✅ After all experiments in series complete
- ✅ When ready to interpret results
- ✅ Before presenting to team/publication

**Too early:**
- ❌ Immediately after experiment (no time to reflect)
- ❌ Before reviewing all results

### 5. Workflow Shortcuts

**Quick experiment (no clarification):**
```
/exp-plan → Execute → /exp-update-labnote → /exp-report
```

**Rigorous experiment (with clarification):**
```
/exp-plan → /exp-clarify → Execute → /exp-update-labnote (multiple) → /exp-report
```

**Multi-experiment project:**
```
/exp-plan (Exp01) → Execute Exp01 → Update Exp01
/exp-plan (Exp02) → Execute Exp02 → Update Exp02
/exp-plan (Exp03) → Execute Exp03 → Update Exp03
/exp-report Exp01-Exp03 (combined report)
```

### 6. Common Pitfalls

| Pitfall | Solution |
|---------|----------|
| Forgetting to update labnote | Set reminder: "Update after each step" |
| Vague success criteria | Always use quantitative metrics |
| Relative paths | Use absolute paths in clarification |
| No tool versions | Record versions immediately |
| Report too technical | Remember: reports are for humans! |

---

## Summary

```
┌────────────────────────────────────────────────────────────┐
│                    Workflow Summary                         │
├────────────────────────────────────────────────────────────┤
│ 1. PLAN      → docs/markdown/Exp##_description.md          │
│    - 4 questions                                            │
│    - 2 minutes                                              │
│                                                             │
│ 2. CLARIFY   → Updates Exp##_description.md                │
│    - Max 5 questions                                        │
│    - 5-10 minutes                                           │
│    - OPTIONAL but recommended                               │
│                                                             │
│ 3. EXECUTE   → Updates Exp##_description.md                │
│    - Update after each major step                           │
│    - Ongoing during analysis                                │
│                                                             │
│ 4. REPORT    → docs/markdown/Exp##_report.md               │
│    - Auto-fill facts from labnote                           │
│    - Human adds interpretation                              │
│    - 30-60 minutes                                          │
└────────────────────────────────────────────────────────────┘

Result: Complete, reproducible, interpretable experiment record
```

**Key Principle**: AI records facts (60%), humans interpret meaning (40%).
