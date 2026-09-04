# Inaccessible resources

Package ID: `TM-20260904-001`
Title: Helium TE PoC Independent Threat Model (Fable 5.1 replay)
Created: 2026-09-04
Status: `Complete`
Distribution: `private`

No blocked resource's contents are implied. Each entry records only what a
supplied copy could confirm.

| Blocked ID | Checked | Resource | Public locator | Access result | Alternatives checked | Priority | What a supplied copy would confirm | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| BLOCKED-001 | 2026-09-04 | RISC-V Privileged Architecture, hypervisor extension chapter (`HFENCE.GVMA` and `htval` sections), v1.12 or current ratified | https://docs.riscv.org/reference/isa/priv/hypervisor.html ; https://five-embeddev.com/riscv-priv-isa-manual/Priv-v1.12/hypervisor.html | Web fetch transport failure on both locators (SEARCH-002, SEARCH-003) | AI-mediated search summary obtained (SEARCH-001); GitHub raw source (BLOCKED-002) | Medium | Primary text of the all-VMID fence semantics (ASSUMPTION-004, OPEN-001) and of `htval` zero permission (THREAT-017, OPEN-006); would allow raising E0064/E0065 confidence to `High`. Sensitivity public; redistribution CC-BY 4.0 (to be confirmed on the copy). | TM-20260904-001-E0064, TM-20260904-001-E0065 |
| BLOCKED-002 | 2026-09-04 | riscv-isa-manual source, `src/hypervisor.adoc` | https://github.com/riscv/riscv-isa-manual | Raw fetch transport failure (SEARCH-003) | None available offline | Medium | Same as BLOCKED-001 from the normative AsciiDoc source with revision history. Sensitivity public; redistribution CC-BY 4.0 (to be confirmed). | TM-20260904-001-E0064, TM-20260904-001-E0065 |
| BLOCKED-003 | 2026-09-04 | Public web search capability for the remaining gap queries (SEARCH-004, SEARCH-005) | n/a (tooling) | Search tool returned transport errors after the first successful query; `threat-research` specialist had no web tools | Orchestrator direct attempts; local evidence substituted where possible | Low | Negative-search completeness for OPEN-002 (optional CSR baseline) and the boot handoff contract. Not a content resource. | None |
