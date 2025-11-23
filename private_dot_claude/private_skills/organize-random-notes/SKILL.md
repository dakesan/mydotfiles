---
name: organize-random-notes
description: This skill should be used when organizing and completing files in the Obsidian repository's random/ folder. It systematically enhances incomplete notes, completes tags according to tags.yaml standards, and moves files to appropriate directories (1_Meeting/, 0_LabNotebook/, or 2_Knowledge/) based on content classification rules. Use this skill when users request to organize random notes, clean up the random folder, or complete unfinished documents.
---

# Organize Random Notes

## Overview

This skill provides a systematic workflow for organizing the `random/` folder in the Hiro Obsidian repository. It processes unfinished notes through completion, tag enhancement, and relocation to appropriate directories. The workflow ensures all documents meet quality standards and are properly categorized before moving them from the temporary `random/` folder to their permanent locations.

## Core Workflow

The organization process follows these sequential phases:

### Phase 1: Assessment and Prioritization

Scan the `random/` folder to identify all markdown files requiring organization.

**Steps:**
1. List all `.md` files in `/Users/oodakemac/Documents/Hiro/random/`
2. Exclude system files (`.DS_Store`, `.claude/`, etc.)
3. Create an inventory of files to process

**Output:** Present the list of files to the user with a count.

### Phase 2: Document Completion

For each file identified, evaluate completeness and enhance as needed.

#### 2.1 Quality Assessment

Read each file and evaluate against completeness criteria:

**Read the reference file:** `references/document_quality_criteria.md`

**Check for:**
- Proper YAML frontmatter
- Complete content sections (not empty)
- Appropriate tags beyond just `random`
- Proper markdown formatting

#### 2.2 Content Enhancement

For incomplete documents, apply enhancement strategies:

**Strategy A: Structured Enhancement**
- Organize scattered notes into proper sections
- Add missing headers (日時, 議事, Tasks for meetings)
- Format lists, code blocks, and tables correctly
- Preserve all original information

**Strategy B: User Consultation**
- If content is minimal or unclear, present the file to user
- Ask specific questions: "What was discussed in this meeting?" or "What was the outcome?"
- Enhance based on user's input

**IMPORTANT RULES:**
- NEVER delete original content
- NEVER substantially change meaning
- Only improve clarity, structure, and formatting
- When in doubt, ask the user

#### 2.3 AI-Assisted Tools

If user provides transcripts or raw notes:
- Suggest using Gemini or other AI tools to structure content
- Offer to format the AI-enhanced output into proper Obsidian format
- Validate the enhanced content with user before proceeding

**Example prompt for AI enhancement:**
```
"This is a rough transcript from a meeting about [topic]. Please structure it into:
- 日時 (date/time)
- 参加者 (participants)
- 議事 (discussion points)
- 決定事項・タスク (decisions and action items)"
```

### Phase 3: Tag Completion

Once content is complete, ensure all tags are proper and complete.

#### 3.1 Load Tag Standards

Read the authoritative tag source:
- **File:** `/Users/oodakemac/Documents/Hiro/tags.yaml`
- **Reference:** `references/tag_completion_guide.md`

#### 3.2 Tag Analysis

For each document:
1. **Identify document type** (meeting, labnote, protocol, survey, technote, quicknote, idea, deepresearch)
2. **Add meeting type** if document is a meeting (pl, bizdev, udc, cmc, recruiting, vendor, management)
3. **Extract content tags** (2-5 tags from research areas, companies, topics)
4. **Validate** all tags exist in tags.yaml
5. **Remove** deprecated tags or `random` tag

#### 3.3 Tag Application

Update the frontmatter with proper tags:

**Format:**
```yaml
tags: [meeting, bizdev, insitro, autologous-therapy]
```

**Validation:**
- Ensure proper case sensitivity (lowercase companies, UPPERCASE acronyms, PascalCase products)
- Verify all tags exist in tags.yaml
- Confirm document has 3-7 total tags

### Phase 4: File Relocation

After documents are complete and properly tagged, determine target directories.

#### 4.1 Load Directory Mapping

Read the directory classification rules:
- **Reference:** `references/directory_mapping.md`

#### 4.2 Classification Logic

Apply classification rules based on document type and content tags:

**Meeting Notes** → `1_Meeting/`
- Weekly meetings: `weekly-bizdev/`, `weekly-udc/`, `weekly-cmc/`, `weekly-pl/`, `weekly-research_pancreas/`
- External meetings: `general_external/`, `bizdev_external/`, `vendor_external/`, `recruiting_external/`, `research_*_external/`, `cmc_external/`
- Internal meetings: `general_internal/`, `management_internal/`, `research_*_internal/`, `cmc_internal/`
- Private: `private/`

**Lab Notebooks/Protocols** → `0_LabNotebook/`
- By topic: `AI/`, `CRISPRa_screening/`, `WholeGenomeSequencing/`, `Pancreas/`, `CloneMax/`, `qPCR/`, `Parse_Biosciences/`, `PacBio/`, `LxBEST Nanopore/`, `HT_GenomeEngineering/`, `Imaging/`, `Infrastructure/`, `Protocol/`

**Knowledge/Research** → `2_Knowledge/`
- Research: `Research_AI_ML/`, `Research_Bioinformatics/`, `Research_Cell_Biology/`, `Research_Aging/`
- Business: `Business_BizDev/`, `Business_Strategy/`, `Business_CMC/`, `Business_HR/`, `Business_Legal/`, `Business_DC/`, `Business_Operations/`
- Others: `Development/`, `Tools/`, `Instruments/`, `Conference/`, `Lecture/`, `Blog_Entry/`, `Cloud_AWS/`, `Config_Server/`, `積読/`

#### 4.3 User Approval for Relocation

**CRITICAL:** Never move files without user approval.

For each file or batch of files:
1. Present the proposed destination
2. Show the reasoning (tags and content-based)
3. Offer alternative destinations if applicable
4. Wait for user confirmation

**Format:**
```
File: 20251110_weeklyBizDev.md
Tags: [meeting, bizdev, insitro]
Proposed: 1_Meeting/weekly-bizdev/
Reason: Weekly BizDev meeting based on tags

Confirm? (yes/no/suggest alternative)
```

**Batch approval option:**
- For multiple files with clear classifications, present as a batch
- Allow user to approve all at once or review individually

#### 4.4 File Movement

After approval, move files using `mv` command:

```bash
mv /Users/oodakemac/Documents/Hiro/random/[filename].md /Users/oodakemac/Documents/Hiro/[target_directory]/[filename].md
```

**Verification:**
- Confirm file moved successfully
- Report to user which files were moved to which directories

## Iteration and Handling Edge Cases

### Handling Ambiguity

When classification is unclear:
1. **Present options** to user with pros/cons
2. **Ask for guidance** on which directory is more appropriate
3. **Document the decision** if it sets a precedent for future files

### Handling Errors

If content enhancement or tag completion fails:
1. **Note the issue** (missing information, unclear content)
2. **Skip to next phase** if possible (e.g., tag completion can proceed even if content is minimal)
3. **Mark for manual review** if user input is needed

### Batch Processing

For efficiency:
1. **Group similar files** (e.g., all meeting notes, all lab notebooks)
2. **Process in batches** rather than one-by-one
3. **Summarize results** at the end of each phase

### Quality Control

After organizing:
1. **Verify** all files have proper tags
2. **Confirm** `random/` folder is empty or only contains files that couldn't be organized
3. **Report summary** to user (X files moved to meetings, Y to lab notebooks, Z to knowledge)

## User Interaction Guidelines

### Communication Style

- **Concise progress updates**: "Processing 15 files from random folder..."
- **Clear questions**: "This file appears to be about X. Should it go to directory A or B?"
- **Batch confirmations**: "Ready to move 5 meeting notes to their destinations. Proceed?"

### Asking for Help

When to ask user:
- Content is too minimal to infer type
- Tags cannot be determined from content
- Multiple directories are equally valid
- Unclear whether to enhance or leave as-is

### Preserving User Intent

- Never assume what user meant in their notes
- When enhancing, keep original phrasing
- If transcription seems garbled, ask user to clarify
- Respect draft status if user wants to keep files incomplete

## Example Workflows

### Example 1: Complete Meeting Note

**Input:** `20251110_weeklyBizDev.md` with complete content and proper tags

**Workflow:**
1. Phase 1: Identify file
2. Phase 2: Assess → Already complete, skip enhancement
3. Phase 3: Validate tags → [meeting, bizdev, insitro] are valid
4. Phase 4: Classify → `1_Meeting/weekly-bizdev/` → Get approval → Move

**Output:** File moved to `1_Meeting/weekly-bizdev/20251110_weeklyBizDev.md`

### Example 2: Incomplete Meeting Note

**Input:** `20251107_PL会議.md` with empty content sections

**Workflow:**
1. Phase 1: Identify file
2. Phase 2: Assess → Incomplete (empty 議事 section) → Ask user: "What was discussed in this PL meeting?" → User provides summary → Add content to 議事 section
3. Phase 3: Check tags → [meeting] exists but missing meeting type → Add `pl` tag based on title
4. Phase 4: Classify → `1_Meeting/weekly-pl/` → Get approval → Move

**Output:** Enhanced file moved to `1_Meeting/weekly-pl/20251107_PL会議.md`

### Example 3: Untagged Lab Note

**Input:** `20251110_プラスミド精製実験について.md` with only [random] tag

**Workflow:**
1. Phase 1: Identify file
2. Phase 2: Assess → Content is complete
3. Phase 3: Tag analysis → Content mentions プラスミド精製, participants Odake/Ohno/紙さん, experimental discussion → Determine: `labnote` (document type) + content tags → Update to [labnote, bacteria-culture, protocol]
4. Phase 4: Classify → `0_LabNotebook/Protocol/` or `0_LabNotebook/Infrastructure/` → Ask user which is more appropriate → Move based on user choice

**Output:** Tagged and moved file

### Example 4: Batch Processing

**Input:** 10 files in random folder, 6 are weekly meetings, 2 are lab notes, 2 are vendor meetings

**Workflow:**
1. Phase 1: Identify all 10 files
2. Phase 2: Assess all → 2 files need content enhancement → Enhance those 2
3. Phase 3: Complete tags for all 10 files
4. Phase 4:
   - Present batch: "6 weekly meetings → respective weekly-* folders"
   - Present batch: "2 vendor meetings → vendor_external/"
   - Present batch: "2 lab notes → appropriate lab folders"
   - Get approval for each batch → Move all

**Output:** All 10 files organized, random folder cleaned

## Resources

This skill includes reference documentation in the `references/` directory:

- **`directory_mapping.md`**: Complete mapping of file types and content to target directories
- **`tag_completion_guide.md`**: Tag standards, naming conventions, and completion process
- **`document_quality_criteria.md`**: Criteria for assessing document completeness and enhancement strategies

Read these reference files as needed during the workflow phases.
