# Search log

Package ID: `TM-20260904-001`
Title: Helium TE PoC Independent Threat Model (Fable 5.1 replay)
Created: 2026-09-04
Status: `Complete`
Distribution: `private`

Local tiers 1–6 were swept by three `threat-evidence` specialists and the
orchestrator; those sweeps are recorded in `discovery.md` (deterministic
discovery, TM-20260904-001-E0003) and `evidence-ledger.md`. This log records
public (tier 7) queries. A `threat-research` specialist was dispatched but had
no web tooling in its environment and returned without results; the
orchestrator performed the queries below directly. All queries used generic
public-safe terms only.

| Search ID | Checked | Tier | Tool | Exact public-safe terms or local pattern | Result | Evidence IDs | Limitation |
| --- | --- | --- | --- | --- | --- | --- | --- |
| SEARCH-001 | 2026-09-04 | 7 public | AI-mediated web search | RISC-V privileged specification hypervisor extension HFENCE.GVMA rs1=x0 rs2=x0 semantics all VMIDs; htval guest-page fault zero permitted | Positive: summaries citing docs.riscv.org, five-embeddev Priv-v1.12 mirror, riscv-unified-db, rvopcode, instructionsets.com agree on all-GPA/all-VMID fence scope and on `htval` zero being permitted when GPA unknown. | TM-20260904-001-E0064, TM-20260904-001-E0065 | Secondary summary; primary pages not read. |
| SEARCH-002 | 2026-09-04 | 7 public | Web fetch | https://docs.riscv.org/reference/isa/priv/hypervisor.html | Negative: transport failure, no content. | None | BLOCKED-001 |
| SEARCH-003 | 2026-09-04 | 7 public | Web fetch | https://five-embeddev.com/riscv-priv-isa-manual/Priv-v1.12/hypervisor.html; https://raw.githubusercontent.com/riscv/riscv-isa-manual/… hypervisor.adoc | Negative: transport failure, no content. | None | BLOCKED-001, BLOCKED-002 |
| SEARCH-004 | 2026-09-04 | 7 public | AI-mediated web search | RISC-V hypervisor extension G-stage TLB VMID 0 reuse stale translation hazard; QEMU RISC-V H-extension htval reporting | Negative: search tool returned transport errors on every attempt after SEARCH-001. | None | BLOCKED-003 |
| SEARCH-005 | 2026-09-04 | 7 public | AI-mediated web search | OpenSBI hart handoff a0 hartid a1 device tree HS-mode entry contract | Negative: search tool unavailable (transport error). | None | BLOCKED-003; local evidence E0019, E0034 used instead |
