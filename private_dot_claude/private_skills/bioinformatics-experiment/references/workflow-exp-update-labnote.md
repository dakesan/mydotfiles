# Labnote Update Workflow (exp-update-labnote)

## Purpose

Update an existing experiment labnote with commands, results, observations, or issues encountered during execution.

## Execution Steps

### 1. Parse Experiment Number

From arguments or ask user:
- Format: Exp## (e.g., Exp01, Exp02)

### 2. Find and Read Labnote

- Path: `docs/markdown/Exp##_*.md` or `docs/markdown/YYYYMMDD_*.md`
- If not found, suggest running exp-plan first

### 3. Ask What to Add

Get user input on what type of update:
- New process step with command
- Results/observations
- Issues encountered
- Tool versions (if new tool used)

### 4. For New Process Step

Gather:
- **Step name/action**: What was done
- **Rationale**: Brief thought or reason (why this step, why this approach)
- **Command**: Complete command with all parameters
- **Result**: What happened - numbers, metrics, status

### 5. Append to Process Section

Add in timeline format:

```markdown
### Step N: [ACTION]

[THOUGHT/RATIONALE]

```bash
[COMMAND]
```

Result: [RESULT]
```

### 6. For Results Summary or Next Steps

Append bullet points with:
- Specific numbers and observations
- Key findings or metrics
- Follow-up actions needed

### 7. Save Updated File

Write changes to the labnote file.

### 8. Report to User

```
✓ Labnote updated

File: docs/markdown/Exp##_description.md

Added:
- [What was added]
```

## Notes

- Keep additions simple and factual
- Record what was done and what happened
- Don't write lengthy explanations - this is a lab notebook, not documentation
- Commands should be reproducible (include all parameters)
- Results should include specific numbers/metrics when available
