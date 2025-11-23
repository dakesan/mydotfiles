---
name: bioinformatics-experiment
description: This skill should be used when managing bioinformatics experiment workflows including creating experiment plans (labnotes), resolving ambiguities through interactive Q&A, tracking execution progress, or generating analysis reports from completed experiments. Triggers include requests like "Create new experiment for [analysis]", "Clarify experiment requirements", "Update labnote with [results]", or "Generate report for Exp##".
---

# Bioinformatics Experiment Management

## Overview

Structured workflows for managing bioinformatics experiments in an AI-first research environment. Provides systematic experiment planning, interactive clarification, progress tracking, and report generation with templates optimized for 60% AI-readable (structured) and 40% human-readable (interpretive) content.

## Core Capabilities

Four main workflows for experiment management:

1. **Experiment Planning** - Create new experiment labnotes with proper numbering and structure
2. **Experiment Clarification** - Resolve ambiguities through targeted Q&A before execution
3. **Labnote Updates** - Track execution progress with commands and results
4. **Report Generation** - Create analysis reports from completed experiments

## Workflow Selection

Determine which workflow to use based on user intent:

```
User request → Workflow

"Create new experiment" / "Plan [analysis]" / "New labnote"
  → Experiment Planning Workflow

"Clarify [experiment]" / "Resolve ambiguities" / "Define inputs/outputs"
  → Experiment Clarification Workflow

"Update [experiment]" / "Record command" / "Add results"
  → Labnote Update Workflow

"Generate report" / "Summarize experiments" / "Create analysis report"
  → Report Generation Workflow
```

## Experiment Planning Workflow

### Purpose

Create new experiment labnotes with proper numbering, structure, and metadata.

### When to Use

Trigger when user requests creating a new experiment, starting a new analysis pipeline, or beginning a new research phase.

### Procedure

1. Find next experiment number by searching `docs/markdown/Exp*.md` files
2. Gather essential information (4 questions max): title, objective, input path, output path
3. **MUST load template from `assets/labnote.md`** - This is the ONLY template to use for experiment labnotes
4. Replace placeholders with user-provided information:
   - `[EXP_NUMBER]` - Zero-padded experiment number (01, 02, etc.)
   - `[TITLE]` - Experiment title
   - `[DATE]` - Current date (YYYY-MM-DD)
   - `[AUTHOR]` - User name
   - `[OBJECTIVE]` - Experiment objective
   - Leave other placeholders for later (tools, versions, etc.)
5. Write file to `docs/markdown/Exp##_description.md`
6. Report completion and suggest running Experiment Clarification Workflow

**Important**:
- **ALWAYS use `assets/labnote.md` template** - Never create labnotes from scratch
- Keep questioning minimal (only essentials)
- Leave tool versions as placeholders for later

**Output**: `docs/markdown/Exp##_description.md` with Trial-based structure, YAML frontmatter, and Callout sections.

See `references/workflow-exp-plan.md` for detailed step-by-step instructions.

## Experiment Clarification Workflow

### Purpose

Identify underspecified areas in experiment plans and resolve through targeted Q&A (max 5 questions). Prevent wasted computational resources by ensuring clear input/output paths, data formats, success criteria, and resource requirements before execution.

### When to Use

Trigger after creating experiment plan (before execution), when experiment plan lacks critical details, or to validate paths, formats, and expectations.

### Procedure

1. Parse experiment number and read labnote from `docs/markdown/Exp##_*.md`
2. Load `pyproject.toml` for compute resource defaults
3. Perform coverage scan across 8 categories (Objective, Input Data, Output, Method, Success Criteria, Resources, Edge Cases, Context)
4. Generate up to 5 prioritized questions (Path > Format > Success Criteria > Tool Choice > Context)
5. Present questions ONE at a time (multiple choice or short answer)
6. After EACH answer: validate, update labnote immediately, add to `## Clarifications` section, replace vague terms with specifics
7. Report coverage summary and readiness assessment

**Critical Rules**:
- Always prioritize path clarification first (absolute paths required)
- Replace vague statements with quantitative metrics ("quality data" → "Q-score ≥20")
- Save file after each answer (atomic writes)
- Never exceed 5 questions
- Respect early termination signals

**Output**: Updated labnote with `## Clarifications` section and refined descriptions.

See `references/workflow-exp-clarify.md` for comprehensive instructions including coverage scan categories and question templates.

## Labnote Update Workflow

### Purpose

Update existing experiment labnotes with commands, results, observations, or issues during execution.

### When to Use

Trigger after executing analysis steps, when recording tool commands and parameters, documenting results and observations, or noting issues or unexpected findings.

### Procedure

1. Parse experiment number and find labnote at `docs/markdown/Exp##_*.md` (or `YYYYMMDD_*.md`)
2. If not found, suggest running Experiment Planning Workflow
3. Ask user what to add: new process step, results/observations, issues, or tool versions
4. For new process steps: gather step name, rationale, complete command, and result
5. Append to labnote in timeline format under `## Trial N` → `### Methods`
6. For results/observations: append bullet points with specific numbers and metrics
7. Save and report what was added

**Important**: Keep additions simple and factual. Record what was done and what happened. Commands must be reproducible (include all parameters). Include specific numbers/metrics when available.

**Output**: Updated labnote with new Methods steps or Results sections.

See `references/workflow-exp-update-labnote.md` for details and formatting examples.

## Report Generation Workflow

### Purpose

Create comprehensive analysis reports from completed experiments. Reports are human-focused (40% of project content), emphasizing interpretation and biological meaning.

### When to Use

Trigger when experiment(s) are completed, ready to interpret and discuss findings, or need formal documentation of results.

### Procedure

1. Parse experiment range (single: Exp## or range: Exp##-Exp##)
2. Read corresponding labnotes from `docs/markdown/Exp##_*.md` and extract objectives, methods, findings, tool versions
3. Ask user for report details: title, main findings, biological interpretations (optional), author name
4. Load template from `assets/report.md`
5. Auto-fill from labnotes: title, date, author, objective, data, pipeline steps, tool versions, labnote references
6. Leave interpretation placeholders for human input: `[INTERPRETATION]`, `[IMPLICATIONS]`, `[CONCLUSIONS]`
7. Write file to `docs/markdown/Exp##_report.md` (or range: `Exp##-##_report.md`)
8. Report completion and list sections needing human input

**Important**: Auto-fill factual information from labnotes. Leave interpretation and discussion sections for human input. Reports focus on "why" and biological meaning, not just "what". Include citations to labnotes, figures, and data files using `[^N]` notation.

**Output**: `docs/markdown/Exp##_report.md` with auto-filled facts and placeholders for human interpretation.

See `references/workflow-exp-report.md` for details on report structure and citation system.

## Project Context

### Directory Structure

Assume project follows this structure:
```
docs/
├── notebook/         # Jupyter notebooks for analysis (Exp##_*.ipynb)
└── markdown/         # Labnotes and reports (Exp##_*.md, report_*.md)

data/
└── raw/              # Raw data (gitignored)

results/              # Analysis outputs (gitignored)
└── Exp##_*/

config/               # YAML configuration files (optional)
└── YYYYMMDD_Exp##_*.yaml

pyproject.toml        # Project settings (compute resources)
```

### Compute Resources

Default resources from `pyproject.toml`:
```toml
[tool.bioinfo-experiment.compute]
total_cores = 128
total_memory_gb = 512
default_cores = 90        # 70% of total
default_memory_gb = 358   # 70% of total
```

Use these defaults unless experiment requires different allocation.

### File Naming Conventions

- Labnotes: `docs/markdown/YYYYMMDD_description.md` or `docs/markdown/Exp##_description.md`
- Reports: `docs/markdown/Exp##_report.md` or `docs/markdown/report_description.md`
- Notebooks: `docs/notebook/Exp##_description.ipynb`
- Configs: `config/YYYYMMDD_Exp##_description.yaml` (optional)
- Results: `results/Exp##_description/` or `results/YYYYMMDD_description/`

All experiment numbers zero-padded to 2 digits (01, 02, ..., 10, 11, ...).

## Templates

This skill includes three templates in `assets/`:

### 1. labnote.md (REQUIRED for all experiment labnotes)

**CRITICAL**: This template MUST be used for ALL experiment labnotes. Never create labnotes from scratch.

**Structure**:
- **YAML Frontmatter**: cdate, mdate, tags, status, author
- **Callout Sections**:
  - `>[!Todo] Background` - Research background and test ID
  - `>[!Works] Purpose` - Experimental objectives and hypotheses
  - `>[!Done] Results Summary` - Key findings summary
  - `>[!Important] Key Points` - Technical notes and considerations
- **Experimental Timeline**: Table tracking all trials
- **Trial-based Structure**: Each trial with Plan → Materials & Tools → Methods → Results → Discussion
- **総合考察と結論**: Overall synthesis with 主要な発見, 今後の方向性, 最終推奨事項

**Key Features**:
- Obsidian-compatible (Callout syntax preserved)
- Trial-based workflow (Trial 1, Trial 2, ...)
- Materials & Tools section with datasets, scripts, and output directories
- Execution time tracking
- Comprehensive conclusion section with recommendations

### 2. report.md - Analysis report template with citation system

Analysis report template for completed experiments with auto-fillable facts and interpretation placeholders.

### 3. config.yaml - Optional configuration file template

Optional YAML configuration for complex parameter sets.

**Placeholder Syntax**: All templates use `[PLACEHOLDER_NAME]` format (e.g., `[EXP_NUMBER]`, `[TITLE]`, `[DATE]`).

## Workflow References

Detailed procedural instructions available in `references/`:

- `workflow-exp-plan.md` - Experiment Planning Workflow
- `workflow-exp-clarify.md` - Experiment Clarification Workflow
- `workflow-exp-update-labnote.md` - Labnote Update Workflow
- `workflow-exp-report.md` - Report Generation Workflow

Load relevant reference files as needed for comprehensive instructions.

## Usage Examples

**Creating new experiment:**
```
User: "Create a new experiment for RNA-seq quality control"
→ Use Experiment Planning Workflow
→ Assign Exp##, create labnote from template
→ Recommend running Clarification Workflow
```

**Clarifying experiment plan:**
```
User: "Clarify Exp03 - I need to define the inputs"
→ Use Experiment Clarification Workflow
→ Prioritize input/output path questions
→ Update labnote with absolute paths and formats
```

**Recording execution:**
```
User: "I ran FastQC on the samples, update Exp03"
→ Use Labnote Update Workflow
→ Add command, parameters, and results to labnote
```

**Generating report:**
```
User: "Create a report for Exp01-03"
→ Use Report Generation Workflow
→ Extract data from labnotes
→ Create report with auto-filled facts, leave interpretations for user
```

## Best Practices

1. **Keep labnotes simple** - Record facts, commands, and observations
2. **Prioritize path clarity** - Always use absolute paths in clarifications
3. **Update incrementally** - Update labnotes during execution, not after
4. **Report thoughtfully** - Reports need human interpretation and insight
5. **Follow numbering** - Always check highest Exp## and increment
6. **Use templates** - Leverage provided templates for consistency
7. **Validate paths** - Ensure input/output paths exist and are correct
8. **Document rationale** - Record "why" decisions were made
9. **Include metrics** - Always provide specific numbers and measurements
10. **Cite sources** - In reports, cite labnotes, figures, and data files
