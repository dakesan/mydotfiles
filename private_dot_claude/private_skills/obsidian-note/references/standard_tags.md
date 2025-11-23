# Standard Tags Reference

> [!warning] DEPRECATED
> This file is deprecated. Please use `/Users/oodakemac/Documents/Hiro/tags.yaml` instead.
> The YAML format provides better structure and programmatic access to tag definitions.

---

**Legacy documentation below - for reference only**

This document defines the standard tags used across the Hiro Obsidian repository. **Always use these exact tag names to avoid inconsistencies.**

## Document Type Tags (Required)

Every document must have one primary document type tag:

- `meeting` - Meeting notes
- `labnote` - Lab notebook entries
- `protocol` - Experimental protocols
- `survey` - Research surveys and literature reviews
- `technote` - Technical memos and how-to guides
- `quicknote` - Quick notes and temporary ideas
- `idea` - Ideas and brainstorming

## Meeting Type Tags

Use with `meeting` tag to specify meeting category:

- `pl` - Project Leader meeting
- `bizdev` - Business Development meeting
- `udc` - UDC weekly meeting
- `cmc` - CMC (Chemistry, Manufacturing, Controls) meeting
- `recruiting` - Recruitment interviews
- `vendor` - Vendor meetings
- `management` - Management meetings

## Research Area Tags

### Core Technologies
- `ai` - Artificial Intelligence / Machine Learning
- `automation` - Laboratory automation
- `bioinformatics` - Bioinformatics analysis
- `CRISPR` - CRISPR/gene editing experiments
- `screening` - High-throughput screening

### Disease/Application Areas
- `pancreas` - Pancreatic differentiation / beta cells
- `autologous-therapy` - Autologous cell therapy
- `variant-analysis` - Genetic variant analysis
- `WGS` - Whole Genome Sequencing

### Technical Areas
- `imager` - Imaging systems
- `bacteria-culture` - Bacterial culture work
- `deepwell-plate` - Deep-well plate experiments

## Company/Organization Tags

### Partners & Vendors
- `aws` - Amazon Web Services
- `google` - Google
- `microsoft` - Microsoft
- `nvidia` - NVIDIA

### Pharma/Biotech Companies
- `bridgestone` - Bridgestone
- `catalent` - Catalent
- `charlesriver` - Charles River
- `genscript` - GenScript
- `kenai-therapeutics` - Kenai Therapeutics
- `lineabio` - Linea Bio
- `lonza` - Lonza
- `merck` - Merck
- `miltenyi` - Miltenyi Biotec
- `minaris` - Minaris
- `nipponagri` - Nippon Agri
- `omniabio` - Omnia Bio
- `parsebio` - Parse Biosciences
- `peptistar` - Peptistar
- `persistense` - Persistense
- `promega` - Promega
- `sigma` - Sigma-Aldrich
- `sony` - Sony
- `synthego` - Synthego
- `takara` - Takara Bio
- `thermofisher` - Thermo Fisher
- `touchlight` - Touchlight
- `vectorbuilder` - VectorBuilder
- `waters` - Waters

### Equipment/Platform Vendors
- `cellistic` - Cellistic
- `hamilton` - Hamilton (use lowercase only)
- `moleculardevices` - Molecular Devices
- `revvity` - Revvity
- `yokogawa` - Yokogawa

### Software/Tools
- `Cellflow` - Cellflow
- `CloneMax` - CloneMax
- `Squidiff` - Squidiff
- `asana` - Asana

### Organizations/Institutions
- `cirm` - California Institute for Regenerative Medicine
- `fti` - FTI
- `iconm` - iCONM
- `ipeace` - iPeace
- `jac` - JAC

## Funding & Grants
- `grant` - Grant applications
- `funding` - Funding-related discussions

## Special Purpose Tags
- `deepresearch` - Deep research/comprehensive survey
- `excalidraw` - Excalidraw diagrams
- `private` - Private/confidential notes
- `random` - Random notes

## Deprecated/Avoid Tags

These tags should NOT be used (inconsistent or template placeholders):
- ~~`Hamilton`~~ - Use `hamilton` (lowercase)
- ~~`category`~~ - Too generic, use specific tags
- ~~`topic`~~ - Too generic, use specific tags
- ~~`topic-tag`~~ - Template placeholder
- ~~`meeting-type`~~ - Template placeholder
- ~~`subject-area`~~ - Template placeholder
- ~~`tag1`, `tag2`, `tag3`~~ - Template placeholders
- ~~`{topic name}`~~ - Template placeholder
- ~~`technique`~~ - Use specific technique name
- ~~`tool`~~ - Use specific tool name
- ~~`comparison`~~ - Too generic
- ~~`experiment`~~ - Redundant with `labnote`
- ~~`lab-equipment`~~ - Use specific equipment name

## Tag Usage Guidelines

1. **Required Tags**: Every document must have:
   - One document type tag (`meeting`, `labnote`, `protocol`, etc.)
   - Relevant subtags based on content

2. **Meeting Tags**: Meeting notes must have:
   - `meeting` (always)
   - Meeting type tag (`pl`, `bizdev`, `udc`, etc.)
   - Additional content tags (companies, technologies, topics)

3. **Content Tags**: Add 2-5 content tags that describe:
   - Technologies involved (`ai`, `automation`, `CRISPR`)
   - Companies/vendors mentioned (`thermofisher`, `aws`)
   - Research areas (`pancreas`, `screening`)

4. **Case Sensitivity**: Tags are case-sensitive in Obsidian
   - Company/product names: Use lowercase unless proper branding (`hamilton`, not `Hamilton`)
   - Acronyms: Use uppercase (`AI`, `AWS`, `WGS`, `CRISPR`)
   - General terms: Use lowercase (`meeting`, `protocol`, `automation`)

5. **New Tags**: Before creating a new tag:
   - Check if a similar tag exists in this list
   - Use existing tags when possible
   - Add new tags to this document for future reference

## Tag Format in Frontmatter

Always use inline array format:

```yaml
tags: [meeting, pl, ai, automation]
```

**NOT** multiline format:
```yaml
# DON'T USE THIS:
tags:
  - meeting
  - pl
```

## Examples

### Meeting Note
```yaml
tags: [meeting, vendor, moleculardevices, automation, imager]
```

### Lab Notebook
```yaml
tags: [labnote, CRISPR, pancreas, screening]
```

### Technical Memo
```yaml
tags: [technote, aws, bioinformatics]
```

### Survey
```yaml
tags: [survey, deepresearch, ai, automation]
```
