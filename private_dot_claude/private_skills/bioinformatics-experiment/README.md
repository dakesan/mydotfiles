# Bioinformatics Experiment Management Skill

**Version**: 2.0.0
**Last Updated**: 2025-11-01
**Status**: Active

## Overview

A comprehensive skill for managing bioinformatics experiments in an AI-first research environment. Provides structured workflows for experiment planning, clarification, execution tracking, and report generation.

## Philosophy

**60% AI-readable / 40% Human-readable**

- **AI-readable (60%)**: Structured records, commands, parameters, metrics → Labnotes
- **Human-readable (40%)**: Interpretations, discussions, implications → Reports

## Core Workflows

### 1. Experiment Planning (`/exp-plan`)
Create new experiment labnotes with proper numbering and structure.

**When to use**: Starting a new experiment or analysis

**Output**: `docs/markdown/Exp##_description.md`

### 2. Experiment Clarification (`/exp-clarify`)
Resolve ambiguities through targeted Q&A (max 5 questions) before execution.

**When to use**: After planning, before execution (recommended)

**Priority**: Path specification > Data format > Success criteria

### 3. Labnote Updates (`/exp-update-labnote`)
Track execution progress with commands, results, and observations.

**When to use**: During experiment execution

**Update types**: New steps, results, issues, tool versions

### 4. Report Generation (`/exp-report`)
Create comprehensive analysis reports from completed experiments.

**When to use**: After experiment completion

**Output**: `docs/markdown/Exp##_report.md`

## Directory Structure

```
project/
├── docs/
│   ├── notebook/         # Jupyter notebooks (.ipynb)
│   │   └── Exp01_analysis.ipynb
│   └── markdown/         # Labnotes and reports (.md)
│       ├── Exp01_labnote.md
│       └── Exp01_report.md
├── data/
│   └── raw/              # Raw data (gitignored)
├── results/              # Analysis outputs (gitignored)
│   └── Exp01_*/
├── config/               # YAML configs (optional)
└── pyproject.toml        # Project settings
```

## File Naming Conventions

- **Labnotes**: `Exp##_description.md` or `YYYYMMDD_description.md`
- **Reports**: `Exp##_report.md` or `report_description.md`
- **Notebooks**: `Exp##_description.ipynb`
- **Results**: `results/Exp##_description/` or `results/YYYYMMDD_description/`

All experiment numbers zero-padded to 2 digits (01, 02, ..., 99).

## Templates

Three templates available in `assets/`:

1. **labnote.md** - Experiment log with Trial-based structure
2. **report.md** - Analysis report with citation system
3. **config.yaml** - Optional configuration file

## Quick Start

```bash
# 1. Create new experiment
/exp-plan

# 2. Clarify requirements (recommended)
/exp-clarify

# 3. Execute experiment (update labnote as you go)
/exp-update-labnote

# 4. Generate report
/exp-report
```

## Features

### Humble AI Philosophy
- AI records facts, humans interpret meaning
- Proactive guidance without overstepping
- Clear boundaries between AI and human roles

### Progressive Disclosure
- Start simple (essential info only)
- Add complexity as needed
- Minimal questions, maximum clarity

### AI-First Workflow
- Optimized for AI continuation
- Clear, parseable structure
- Reproducible commands

## Version History

### v2.0.0 (2025-11-01)
- **Breaking**: Changed directory structure from `notebook/` to `docs/`
- Separated notebooks and markdown files
- Updated all workflow references
- See CHANGELOG.md for details

### v1.0.0 (2025-10-27)
- Initial release
- Four core workflows
- Trial-based labnote structure
- Citation-based report system

## Migration from v1.x

If upgrading from v1.x:

```bash
mkdir -p docs/notebook docs/markdown data/raw
mv notebook/labnote/* docs/markdown/
mv notebook/analysis/* docs/notebook/
mv notebook/report/* docs/markdown/
rm -rf notebook/
```

Update path references in your documents.

## Documentation

- **SKILL.md** - Main skill definition
- **CHANGELOG.md** - Version history and changes
- **references/** - Detailed workflow instructions
  - `workflow-exp-plan.md`
  - `workflow-exp-clarify.md`
  - `workflow-exp-update-labnote.md`
  - `workflow-exp-report.md`

## Configuration

Default compute resources (override in `pyproject.toml`):

```toml
[tool.bioinfo-experiment.compute]
total_cores = 128
total_memory_gb = 512
default_cores = 90        # 70% of total
default_memory_gb = 358   # 70% of total
```

## Best Practices

1. **Run clarification before execution** - Saves time and resources
2. **Update labnotes incrementally** - Don't wait until the end
3. **Keep labnotes factual** - Commands, numbers, observations
4. **Make reports interpretive** - Discuss meaning and implications
5. **Use absolute paths** - Especially in clarifications
6. **Document rationale** - Record "why" decisions were made
7. **Include metrics** - Always provide specific measurements
8. **Cite sources** - Reference labnotes, figures, data files

## Examples

See test project: `BItemplate/` (Squidiff evaluation)
- Labnote: `docs/markdown/20251101_squidiff-testing.md`
- Report: `docs/markdown/Exp01_squidiff-evaluation-report.md`
- Notebook: `docs/notebook/Exp01_squidiff-basic-test.ipynb`

## Support

For issues or questions:
- Check workflow references in `references/`
- Review CHANGELOG.md for recent changes
- Examine example project structure

## License

Part of Claude Code skills ecosystem.

---

**Note**: This skill works best with projects following the directory structure above. Adapt as needed for your specific use case.
