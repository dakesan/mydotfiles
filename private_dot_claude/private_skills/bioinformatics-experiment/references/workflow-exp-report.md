# Analysis Report Creation Workflow (exp-report)

## Purpose

Create a comprehensive analysis report from one or more completed experiments. This report is human-focused (40% of project content), emphasizing interpretation and biological meaning.

## Execution Steps

### 1. Parse Experiment Range

From arguments or ask user:
- Single: Exp## (e.g., Exp03)
- Range: Exp##-Exp## (e.g., Exp01-Exp03)

### 2. Read Corresponding Labnotes

Gather context from:
- Files: `docs/markdown/Exp##_*.md` or `docs/markdown/YYYYMMDD_*.md`
- Extract:
  - Objectives
  - Methods used
  - Key findings
  - Tool versions and commands

### 3. Ask for Report Details

Get user input on:
- **Report title**: Descriptive title for the report
- **Main findings**: Key results to highlight
- **Biological interpretations**: Initial interpretations (if ready)
- **Author name**: Report author

### 4. Load Template

Load the report template from skill assets: `assets/report.md`

### 5. Replace Placeholders

Auto-fill from labnotes:
- `[TITLE]` → User's report title
- `[EXP_RANGE]` → Exp## or Exp##-Exp##
- `[DATE]` → Current date (YYYY-MM-DD)
- `[AUTHOR]` → User's name
- `[OBJECTIVE]` → Extracted from labnotes
- `[DATA_DESCRIPTION]` → Summarize from labnotes
- `[STEP1]`, `[STEP2]` → Major pipeline steps from labnotes
- `[LABNOTE_REFS]` → List of labnote files used
- `[TOOL1]`, `[VERSION]` → Extract from labnotes

Leave interpretation placeholders for user to fill:
- `[INTERPRETATION]`
- `[IMPLICATIONS]`
- `[SIGNIFICANCE_DISCUSSION]`
- `[CONCLUSIONS]`

### 6. Create File

Write to: `docs/markdown/Exp##_report.md` or `docs/markdown/report_description.md`

### 7. Report to User

```
✓ Analysis report created

File: docs/markdown/Exp##_report.md
Experiments covered: Exp##-Exp##

Auto-filled sections:
- Objective
- Data description
- Analysis pipeline
- Software versions
- Labnote references

Sections to complete (HUMAN INPUT):
- Results interpretation
- Biological implications
- Discussion of findings
- Conclusions

This is for HUMANS - write clearly and completely with thoughtful interpretation.
```

## Notes

- Auto-fill factual information from labnotes
- Leave interpretation and discussion sections for human input
- Reports should focus on "why" and biological meaning, not just "what"
- Include citations to labnotes, figures, and data files
- Reports are the 40% human-readable content of the project
