# Directory Mapping Guide

This document defines the rules for organizing files from the `random/` folder into appropriate directories in the Hiro Obsidian repository.

## Classification Rules

Files in `random/` should be moved to one of three main categories based on their content:

### 1. Meeting Notes → `1_Meeting/`

**Criteria:**
- Document type tag is `meeting`
- Contains meeting metadata (date, attendees, agenda, tasks)
- Represents discussions, decisions, or action items from meetings

**Target Subdirectories:**

#### Weekly Meetings (Internal)
- `weekly-bizdev/` - Business Development weekly meetings (tags: `meeting`, `bizdev`)
- `weekly-udc/` - UDC weekly meetings (tags: `meeting`, `udc`)
- `weekly-cmc/` - CMC weekly meetings (tags: `meeting`, `cmc`)
- `weekly-pl/` - Project Leader meetings (tags: `meeting`, `pl`)
- `weekly-research_pancreas/` - Pancreas research weekly meetings (tags: `meeting`, `pancreas`)

#### External Meetings
- `general_external/` - General external meetings
- `bizdev_external/` - Business development external meetings
- `vendor_external/` - Vendor meetings (tags: `meeting`, `vendor`, company tags)
- `recruiting_external/` - Recruitment interviews (tags: `meeting`, `recruiting`)
- `research_ai_external/` - AI research external meetings (tags: `meeting`, `ai`)
- `research_bioinformatics_external/` - Bioinformatics external meetings (tags: `meeting`, `bioinformatics`)
- `research_pancreas_external/` - Pancreas research external meetings (tags: `meeting`, `pancreas`)
- `cmc_external/` - CMC external meetings (tags: `meeting`, `cmc`)

#### Internal Meetings
- `general_internal/` - General internal meetings
- `management_internal/` - Management meetings (tags: `meeting`, `management`)
- `research_ai_internal/` - AI research internal meetings (tags: `meeting`, `ai`)
- `research_bioinformatics_internal/` - Bioinformatics internal meetings (tags: `meeting`, `bioinformatics`)
- `research_pancreas_internal/` - Pancreas research internal meetings (tags: `meeting`, `pancreas`)
- `cmc_internal/` - CMC internal meetings (tags: `meeting`, `cmc`)

#### Other
- `private/` - Private meeting records (tags: `meeting`, `private`)
- `to-triage/` - Meetings that cannot be clearly classified

### 2. Lab Notebook Entries → `0_LabNotebook/`

**Criteria:**
- Document type tag is `labnote` or `protocol`
- Contains experimental procedures, results, or protocols
- Related to research activities

**Target Subdirectories:**
- `AI/` - AI/ML research (tags: `labnote`, `ai`)
- `CRISPRa_screening/` - CRISPR screening experiments (tags: `labnote`, `CRISPR`, `screening`)
- `WholeGenomeSequencing/` - WGS analysis (tags: `labnote`, `WGS`)
- `Pancreas/` - Pancreatic differentiation research (tags: `labnote`, `pancreas`)
- `CloneMax/` - Automated cell culture (tags: `labnote`, `CloneMax`, `automation`)
- `qPCR/` - qPCR experiments (tags: `labnote`)
- `Parse_Biosciences/` - Parse Biosciences experiments (tags: `labnote`, `parsebio`)
- `PacBio/` - PacBio sequencing (tags: `labnote`)
- `LxBEST Nanopore/` - Nanopore sequencing (tags: `labnote`)
- `HT_GenomeEngineering/` - High-throughput genome editing (tags: `labnote`, `CRISPR`)
- `Imaging/` - Imaging experiments (tags: `labnote`, `imager`)
- `Infrastructure/` - Infrastructure-related (tags: `labnote`)
- `Protocol/` - General protocols (tags: `protocol`)

### 3. Knowledge Base → `2_Knowledge/`

**Criteria:**
- Document type tags: `survey`, `technote`, `deepresearch`, `quicknote`, `idea`
- Contains research surveys, technical notes, or general knowledge
- Not tied to specific experiments or meetings

**Target Subdirectories:**

#### Research
- `Research_AI_ML/` - AI/ML research (tags: `ai`)
- `Research_Bioinformatics/` - Bioinformatics research (tags: `bioinformatics`)
- `Research_Cell_Biology/` - Cell biology research
- `Research_Aging/` - Aging research

#### Business
- `Business_BizDev/` - Business development (tags: `bizdev`)
- `Business_Strategy/` - Business strategy
- `Business_CMC/` - CMC-related (tags: `cmc`)
- `Business_HR/` - Human resources
- `Business_Legal/` - Legal matters
- `Business_DC/` - Data center
- `Business_Operations/` - Operations

#### Others
- `Development/` - Development-related
- `Tools/` - Tools and software
- `Instruments/` - Laboratory instruments
- `Conference/` - Conference notes
- `Lecture/` - Lecture notes
- `Blog_Entry/` - Blog entries
- `Cloud_AWS/` - AWS-related (tags: `aws`)
- `Config_Server/` - Server configuration
- `積読/` - Reading list

## Decision Process

When determining the target directory for a file:

1. **Check document type tag** (meeting, labnote, protocol, survey, technote, etc.)
2. **Identify content tags** (research areas, companies, meeting types)
3. **Match to subdirectory** based on the mapping above
4. **Consider specificity**: More specific directories (e.g., `weekly-bizdev/`) take precedence over general ones (e.g., `general_internal/`)
5. **Handle ambiguity**: If multiple directories could apply, present options to the user

## Special Cases

- **Papers**: Files with tags related to academic papers should go to `3_Paper/`
- **Templates**: Files that are templates should remain in `template/` (rarely applies to random files)
- **Lab Reports**: Comprehensive experimental reports should go to `_LabReports/`
- **Uncertain**: When classification is unclear, ask the user for guidance
