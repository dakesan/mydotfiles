# Changelog - Bioinformatics Experiment Skill

## [v2.0.0] - 2025-11-01

### Breaking Changes

**Directory Structure Reorganization**

Changed from `notebook/` based structure to `docs/` based structure for clearer separation of documentation types.

#### Old Structure (v1.x)
```
notebook/
├── labnote/          # Experiment logs
├── analysis/         # Jupyter notebooks
├── report/           # Analysis reports
└── knowledge/        # Background docs

results/              # Analysis outputs
```

#### New Structure (v2.0)
```
docs/
├── notebook/         # Jupyter notebooks (.ipynb)
└── markdown/         # Labnotes and reports (.md)

data/
└── raw/              # Raw data

results/              # Analysis outputs
```

### Changed

#### File Paths
- Labnotes: `notebook/labnote/Exp##_*.md` → `docs/markdown/Exp##_*.md`
- Reports: `notebook/report/Exp##_*.md` → `docs/markdown/Exp##_*.md`
- Notebooks: `notebook/analysis/Exp##_*.ipynb` → `docs/notebook/Exp##_*.ipynb`

#### Workflow Files Updated
1. **SKILL.md**
   - Updated "Directory Structure" section
   - Updated "File Naming Conventions" section

2. **references/workflow-exp-plan.md**
   - Changed output path to `docs/markdown/Exp##_description.md`
   - Updated experiment number search command

3. **references/workflow-exp-update-labnote.md**
   - Changed labnote path to `docs/markdown/Exp##_*.md`
   - Updated completion message paths

4. **references/workflow-exp-report.md**
   - Changed labnote source path to `docs/markdown/`
   - Changed report output path to `docs/markdown/Exp##_report.md`
   - Updated completion message paths

### Migration Guide

If you have existing projects using the old structure:

```bash
# Create new directory structure
mkdir -p docs/notebook docs/markdown data/raw

# Move existing files
mv notebook/labnote/* docs/markdown/
mv notebook/analysis/* docs/notebook/
mv notebook/report/* docs/markdown/

# Remove old structure
rm -rf notebook/
```

Update your project documentation:
- Update all internal path references in markdown files
- Update notebook paths in labnotes
- Update figure paths in reports (should still point to `results/`)

### Rationale

**Why this change?**

1. **Clearer separation**: `docs/` clearly indicates documentation, separate from data and results
2. **Type-based organization**: Notebooks and markdown files are different types, now separated
3. **Simplified structure**: Labnotes and reports are both markdown, no need for separate directories
4. **Industry standard**: Many projects use `docs/` for documentation, `data/` for data
5. **Better for version control**: Clear what should/shouldn't be in git

**Benefits:**
- Easier to find notebooks vs. markdown documents
- More intuitive for new users
- Consistent with common project structures (e.g., data science cookiecutter)
- Scales better for large projects

### Compatibility

- **Commands unchanged**: `/exp-plan`, `/exp-clarify`, `/exp-update-labnote`, `/exp-report` work the same
- **Templates unchanged**: `assets/labnote.md`, `assets/report.md`, `assets/config.yaml` are the same
- **Workflow logic unchanged**: Only file paths changed, not the workflow behavior

### Testing

Tested on:
- Project: BItemplate (Squidiff evaluation)
- Created: Exp01 labnote, notebook, and report
- Verified: All paths consistent, no broken links

---

**Note**: This is a major version bump (v2.0.0) due to breaking changes in directory structure. Existing projects need migration to use new paths.
