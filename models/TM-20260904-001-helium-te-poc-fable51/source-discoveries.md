# Source discoveries

Package ID: `TM-20260904-001`
Title: Helium TE PoC Independent Threat Model (Fable 5.1 replay)
Created: 2026-09-04
Status: `Complete`
Distribution: `private`

Candidate sources were checked by read-only pattern search against the indexes named in
`RESEARCH-SOURCES.md`. One broad negative pattern search over sibling Markdown
files did not exclude the restricted `osr-claude` subtree by path; it returned
no matches and no restricted content was read, displayed or copied
(ACTIVITY-007).
No index entry for the RISC-V Privileged Architecture hypervisor chapter or `riscv-unified-db` was
found, so the entries below are proposed pull-queue candidates, not admitted
retained copies.

| Discovery ID | Checked | Source | Stable public locator | Existing index check | Suggested owner | Package relevance | Status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| DISC-001 | 2026-09-04 | RISC-V Privileged Architecture, hypervisor extension chapter (RISC-V International; v1.12 / current ratified; CC-BY 4.0 to be confirmed) | https://github.com/riscv/riscv-isa-manual (src/hypervisor.adoc); https://docs.riscv.org/reference/isa/priv/hypervisor.html | Read-only pattern search of `workspace://COMPONENTS.md`, `component://formal-verification-research/sources/bibliography.md`, `component://cheri-riscv-notes-repo/references/`, `component://xrv-research-repo/`, non-restricted `component://osr-claude/` indexes, PRV/AWB discovery logs and this repository's `SOURCE-DISCOVERY-LOG.md` for `riscv-isa-manual`, `riscv-unified-db`, `docs.riscv.org`, `Privileged Architecture`: no match | `cheri-riscv-notes-repo` or a public-sources inbox | Primary source for ASSUMPTION-004, THREAT-005, THREAT-017 (E0064, E0065) | Proposed for pull queue; content not retained (BLOCKED-001/002) |
| DISC-002 | 2026-09-04 | riscv-unified-db instruction page for `hfence.gvma` (RISC-V International, generated from the unified database) | https://riscv.github.io/riscv-unified-db/manual/html/isa/isa_20240411/insts/hfence.gvma.html | Same read-only pattern search as DISC-001: no match | `cheri-riscv-notes-repo` | Secondary confirmation for E0064 | Proposed for pull queue; content not retained |
