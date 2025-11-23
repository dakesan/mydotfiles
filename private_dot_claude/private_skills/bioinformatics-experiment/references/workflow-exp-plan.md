# Experiment Planning Workflow (exp-plan)

## Purpose

Create a new experiment labnote with proper numbering, structure, and metadata.

## Execution Steps

### 1. Find Next Experiment Number

```bash
ls -1 docs/markdown/Exp*.md 2>/dev/null | grep -oP 'Exp\K\d+' | sort -n | tail -1
```

- If no experiments exist, start with Exp01
- Otherwise increment by 1
- Zero-pad to 2 digits (01, 02, ..., 10, 11, ...)

### 2. Gather Experiment Details

Ask user for (consider any arguments provided):
- **Title**: Brief descriptive title (lowercase-with-hyphens)
- **Objective**: What they want to accomplish (1-2 sentences)
- **Input data path**: Where the input data is located
- **Expected output location**: Where results will be saved (default: results/Exp##_description)

Keep it simple. Only ask for essential information.

### 3. Load Template

Load the labnote template from skill assets: `assets/labnote.md`

### 4. Replace Placeholders

Replace the following in the template:
- `[EXP_NUMBER]` → Next experiment number (zero-padded: 01, 02, etc.)
- `[TITLE]` → User's title
- `[DATE]` → Current date (YYYY-MM-DD)
- `[DESCRIPTION]` → Lowercase description for file name
- `[OBJECTIVE]` → User's objective
- `[INPUT_PATH]` → User's input path
- `[OUTPUT_PATH]` → results/Exp##_description
- Leave `[TOOL1]`, `[VERSION]`, etc. as placeholders for user to fill later

### 5. Create File

Write to: `docs/markdown/Exp##_description.md`

### 6. Report to User

```
✓ Experiment labnote created

File: docs/markdown/Exp##_description.md
Experiment: Exp##
Title: [title]

Next steps:
- Run /exp-clarify to resolve ambiguities (recommended)
- Start working on the experiment
- Update labnote with /exp-update-labnote as you progress
```

## Notes

- Keep the process simple and quick
- Don't overwhelm the user with too many questions
- The labnote is a living document - details will be filled in during execution
