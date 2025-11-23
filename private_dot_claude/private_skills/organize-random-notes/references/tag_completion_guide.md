# Tag Completion Guide

This document provides guidance for completing and validating Obsidian tags in files from the `random/` folder.

## Tag Sources

The authoritative source for all tags is:
- **File**: `/Users/oodakemac/Documents/Hiro/tags.yaml`

Always reference this file when completing tags.

## Tag Categories

### 1. Document Type Tags (Required)

Every document must have exactly one document type tag:
- `meeting` - Meeting notes
- `labnote` - Lab notebook entries
- `protocol` - Experimental protocols
- `survey` - Research surveys and literature reviews
- `technote` - Technical memos and how-to guides
- `quicknote` - Quick notes and temporary ideas
- `idea` - Ideas and brainstorming
- `deepresearch` - Deep research/comprehensive survey

### 2. Meeting Type Tags (Required for meetings)

If the document type is `meeting`, add one meeting type tag:
- `pl` - Project Leader meeting
- `bizdev` - Business Development meeting
- `udc` - UDC weekly meeting
- `cmc` - CMC meeting
- `recruiting` - Recruitment interviews
- `vendor` - Vendor meetings
- `management` - Management meetings

### 3. Content Tags (2-5 tags recommended)

Add 2-5 content tags from these categories:

#### Research Areas
- `ai` - AI/Machine Learning
- `automation` - Laboratory automation
- `bioinformatics` - Bioinformatics analysis
- `CRISPR` - CRISPR/gene editing
- `screening` - High-throughput screening
- `imager` - Imaging systems
- `pancreas` - Pancreatic differentiation
- `autologous-therapy` - Autologous cell therapy
- `variant-analysis` - Genetic variant analysis
- `WGS` - Whole Genome Sequencing
- `bacteria-culture` - Bacterial culture
- `deepwell-plate` - Deep-well plate experiments

#### Companies/Organizations
- Cloud/Tech: `aws`, `google`, `microsoft`, `nvidia`
- Pharma/Biotech: `bridgestone`, `catalent`, `charlesriver`, `genscript`, `kenai-therapeutics`, `lineabio`, `lonza`, `merck`, `miltenyi`, `minaris`, `nipponagri`, `nissin`, `omniabio`, `parsebio`, `peptistar`, `persistense`, `platinumbio`, `promega`, `sigma`, `sony`, `synthego`, `takara`, `thermofisher`, `thinkcyte`, `touchlight`, `vectorbuilder`, `waters`
- Equipment/Vendors: `cellistic`, `hamilton`, `moleculardevices`, `revvity`, `yokogawa`
- Software/Tools: `Cellflow`, `CloneMax`, `Squidiff`, `asana`
- Organizations: `cirm`, `fti`, `iconm`, `ipeace`, `jac`

#### Funding & Grants
- `grant` - Grant applications
- `funding` - Funding-related discussions

#### Special Purpose
- `excalidraw` - Excalidraw diagrams
- `private` - Private/confidential notes
- `random` - Random notes (should be removed after organization)

## Tag Naming Conventions

Follow these case sensitivity rules:

1. **Company/product names**: lowercase (e.g., `hamilton`, `thermofisher`)
2. **Product names (branded)**: PascalCase (e.g., `CloneMax`, `Cellflow`)
3. **Acronyms**: UPPERCASE (e.g., `AI`, `AWS`, `WGS`, `CRISPR`)
4. **General terms**: lowercase (e.g., `meeting`, `automation`)

## Tag Completion Process

### Step 1: Identify Document Type

Read the document content and determine:
- Is it a meeting note? → `meeting`
- Is it an experiment? → `labnote`
- Is it a protocol? → `protocol`
- Is it a survey/research? → `survey`, `deepresearch`, or `technote`
- Is it a quick idea? → `quicknote` or `idea`

### Step 2: Add Meeting Type (if applicable)

If document type is `meeting`, identify the meeting type from:
- Frontmatter field `meetingType`
- Meeting title or content
- Participants/attendees

### Step 3: Extract Content Tags

Analyze the document content for:
- **Research areas**: What technologies or research areas are discussed?
- **Companies**: Which companies, vendors, or organizations are mentioned?
- **Topics**: What are the main themes?

Select 2-5 most relevant content tags.

### Step 4: Validate Against tags.yaml

Check that all selected tags exist in `/Users/oodakemac/Documents/Hiro/tags.yaml`.

### Step 5: Remove Invalid Tags

Remove any tags that are:
- In the `deprecated` section of tags.yaml
- Template placeholders (e.g., `{topic name}`, `tag1`, `tag2`)
- Not in tags.yaml and cannot be justified

### Step 6: Update Frontmatter

Update the `tags` field in frontmatter using inline array format:
```yaml
tags: [meeting, pl, ai, automation]
```

## Common Tag Patterns

### Meeting Notes
```yaml
tags: [meeting, bizdev, insitro, autologous-therapy]
```

### Lab Notebooks
```yaml
tags: [labnote, CRISPR, pancreas, automation]
```

### Vendor Meetings
```yaml
tags: [meeting, vendor, parsebio, bioinformatics]
```

### Technical Notes
```yaml
tags: [technote, automation, CloneMax, hamilton]
```

## Special Considerations

- **Remove `random` tag**: After organization, the `random` tag should be removed
- **Multiple companies**: Include all relevant company tags (up to 5 total tags)
- **Ambiguous meetings**: If meeting type is unclear, default to `general` and ask user
- **New tags**: If a genuinely new tag is needed, note it for addition to tags.yaml
