# Evidence ledger

Package ID: `TM-20260904-001`
Title: Helium TE PoC Independent Threat Model (Fable 5.1 replay)
Created: 2026-09-04
Status: `Complete`
Distribution: `private`

Evidence IDs are append-only and unique within the package. A correction adds
a new record and names the superseded record.

Every evidence record contains:

- status: `active`, `superseded`, or `withdrawn`;
- fact label, source class, evidentiary role, and affected stable IDs;
- title or description, portable logical locator, and exact revision or date;
- neutral observation and relationship to the modeled surface;
- confidence, confidence basis, alternatives, and limitations;
- sensitivity and redistribution status;
- a content hash when a retained or user-supplied copy is involved;
- `Supersedes` and `Superseded by` links.

## Admission notes

- Evidence IDs are allocated by the orchestrator. Specialist passes returned
  provisional observations; the orchestrator verified material observations
  against its own reads at the frozen revision before consolidating them here.
- Two specialist passes were discarded before admission because the target
  worktree was found switched to a different branch during their reads
  (`ACTIVITY-004` in `scope.md`). Only passes whose revision guard passed at
  start and end were used.
- The prior package `models/TM-20260901-001-helium-te-poc/` was excluded from
  evidence by user instruction; only its `scope.md` intake fields were read.
- All target content is treated as `internal` with `unknown` redistribution
  because `publication-gate.conf` records `status=blocked`. Completed PRV and
  AWB packages are `private` with `not-approved` redistribution.
- Hash: `not-applicable` for every record; no copy was retained.

Revision shorthand: `R1` = `component://helium-te-poc` at
`1ab289c066b69acdd8b55c9f77055b0145be1316` (branch `for-review`, clean);
`R2` = `component://beryllium-repo` at
`65f6d895a2007e8e093582cc48726375fd23b563`; `W` = workspace at
`767752792026622bbb06c3fcd29d240b0871a3e9`.

## Orchestrator-generated records

## TM-20260904-001-E0001

- Status: active
- Fact label: Established
- Class: Target state
- Role: Direct
- Affected IDs: BOUNDARY-001, BOUNDARY-002, BOUNDARY-003, BOUNDARY-004
- Title or description: Frozen target state of `helium-te-poc`
- Logical locator: component://helium-te-poc
- Revision or checked date: 1ab289c066b69acdd8b55c9f77055b0145be1316; checked 2026-09-04T09:12:39Z and re-checked 2026-09-04T09:29:33Z and 2026-09-04T09:38:49Z
- Observation: `scripts/readonly-inspect.sh state helium-te-poc` reported head `1ab289c066b69acdd8b55c9f77055b0145be1316`, branch `for-review`, worktree `clean`, `changed-entries 0` at each check.
- Relationship: Binds every target observation in this ledger to one exact commit.
- Confidence: High
- Confidence basis: Maintained helper output, three independent checks.
- Alternatives and counter-evidence: Between 09:16Z and 09:26Z the same worktree was observed at `9af92cc4ec280251ae50d6dec36d463de1039544` (branch `helium-te-travel-fedora44`); see `ACTIVITY-004`. Observations from that interval were discarded.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: State is a point-in-time check; sub-agent reads were guarded by `.git/HEAD` and `.git/packed-refs` inspection rather than by the helper.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0002

- Status: active
- Fact label: Established
- Class: Target state
- Role: Contextual
- Affected IDs: ASSUMPTION-008
- Title or description: Frozen state of `beryllium-repo` planning context
- Logical locator: component://beryllium-repo
- Revision or checked date: 65f6d895a2007e8e093582cc48726375fd23b563; checked 2026-09-04T09:12:39Z and 2026-09-04T09:38:49Z
- Observation: `scripts/readonly-inspect.sh state beryllium-repo` reported branch `beryllium/single-hart-runtime-r0`, worktree `clean`.
- Relationship: Fixes the revision of the historical TE planning transcripts used as Tier 5 context.
- Confidence: High
- Confidence basis: Maintained helper output.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Beryllium implementation code was not in scope; only planning records were read.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0003

- Status: active
- Fact label: Established
- Class: Discovery
- Role: Negative
- Affected IDs: ASSUMPTION-001
- Title or description: Deterministic discovery found no formal threat model at R1
- Logical locator: component://helium-te-poc
- Revision or checked date: R1; discovery run 2026-09-04T09:13Z
- Observation: `scripts/discover-threat-material.sh component helium-te-poc 1ab289c066b69acdd8b55c9f77055b0145be1316` returned 82 candidates and zero candidates classified `Formal model`; the closest material is `docs/security-and-limits.md` (assumptions and limits), five historical AI review packages under `agent-review/`, and `docs/review-remediation.md`.
- Relationship: Justifies `create-from-evidence` mode; no authoritative source model exists.
- Confidence: High
- Confidence basis: Maintained helper output recorded in `discovery.md`.
- Alternatives and counter-evidence: `agent-review/grok-4.5/01-scope-methodology.md` contains an embedded four-model framing (E0059); it is a historical review input, not a maintained model.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Discovery is pattern-based; generated `docs/html/` was excluded.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0004

- Status: active
- Fact label: Established
- Class: Engagement observation
- Role: Contextual
- Affected IDs: THREAT-016, ASSET-010
- Title or description: Target worktree switched by another party during the evidence pass
- Logical locator: component://helium-te-poc/.git/HEAD
- Revision or checked date: observed 2026-09-04T09:26:51Z; restored by 2026-09-04T09:29:33Z
- Observation: A specialist pass returned observations naming `he_capture_trap_snapshot`, CBMC harness targets and eight negative payloads, none of which exist at R1. `readonly-inspect.sh state` then showed head `9af92cc4…` on branch `helium-te-travel-fedora44`. The user restored `for-review` at `1ab289c…`.
- Relationship: Concrete instance of later-lineage material being attributable to the frozen commit if revision binding is not enforced; informs THREAT-016.
- Confidence: High
- Confidence basis: Direct helper output and comparison with orchestrator reads at R1.
- Alternatives and counter-evidence: The switch was operational, not adversarial; it nonetheless shows the attribution hazard is real in this workspace.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: The contents of the other branch were not analysed and are out of scope.
- Supersedes: none
- Superseded by: none

## Tier 2: target design, limits and code (R1)

## TM-20260904-001-E0005

- Status: active
- Fact label: Established
- Class: Assumptions or limits
- Role: Direct
- Affected IDs: OBJECTIVE-007, ASSUMPTION-001, CONTROL-013
- Title or description: Exact claim-boundary statement
- Logical locator: component://helium-te-poc/README.md; component://helium-te-poc/HANDOFF.md
- Revision or checked date: R1
- Observation: Both files state: "This is a review-and-test PoC. It is not formally verified and has not been validated on hardware."
- Relationship: Defines the assurance ceiling for every claim in this model.
- Confidence: High
- Confidence basis: Orchestrator and specialist reads agree.
- Alternatives and counter-evidence: None at R1.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: A status statement, not independent assurance.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0006

- Status: active
- Fact label: Established
- Class: Design input
- Role: Direct
- Affected IDs: BOUNDARY-001, BOUNDARY-002, BOUNDARY-003, ACTOR-001, ACTOR-002, ACTOR-004
- Title or description: Privilege architecture and trust placement
- Logical locator: component://helium-te-poc/docs/architecture.md
- Revision or checked date: R1
- Observation: OpenSBI runs in M-mode; Helium runs in HS-mode; a writer subject then a reader subject run sequentially in VS-mode. Both VS subjects are described as untrusted; policy and mechanism execute in the HS-mode monitor, which is the TCB. The architecture names exactly six separately linked negative images (early completion, skipped writer denial, `SATP`, `SFENCE.VMA`, `SRET`, `WFI`).
- Relationship: Establishes the system boundary and the two principal trust boundaries.
- Confidence: High
- Confidence basis: Corroborated by `src/entry.S`, `src/main.c`, `src/guest.S` reads.
- Alternatives and counter-evidence: The payloads are linked into the same image as the monitor (E0028), so "untrusted" is a modeling stance rather than a loading boundary.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Descriptive document.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0007

- Status: active
- Fact label: Established
- Class: Assumptions or limits
- Role: Direct
- Affected IDs: ASSET-001, ASSET-002, ASSET-003, ASSET-004, ASSET-005, ASSET-006, ASSET-007, ASSET-009
- Title or description: Maintained protected-asset list
- Logical locator: component://helium-te-poc/docs/security-and-limits.md
- Revision or checked date: R1
- Observation: Section "Protected assets in the fixed experiment" lists HS code, trusted stack, TE state and rules, G-stage roots, active subject and phase, sentinels, private pages, shared-page integrity against the reader, TE/PTE consistency, and terminal `HE_RESULT` PASS/FAIL integrity.
- Relationship: Direct source for the asset table.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Intent statement for the fixed experiment only.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0008

- Status: active
- Fact label: Established
- Class: Assumptions or limits
- Role: Direct
- Affected IDs: ENTRY-002, ENTRY-003, ENTRY-004, ACTOR-003
- Title or description: Maintained untrusted-input list
- Logical locator: component://helium-te-poc/docs/security-and-limits.md
- Revision or checked date: R1
- Observation: Section "Untrusted inputs" treats saved registers, event values, attempted guest addresses, trap CSRs (`scause`, `sepc`, `stval`, `htval`, `hstatus` origin fields), ordering and timing, and all active-subject data as untrusted. Fixed policy source and initializer are trusted.
- Relationship: Defines the attacker-controlled inputs reaching HS.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: The list does not enumerate microarchitectural inputs (explicitly excluded, E0014).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: No runtime untrusted policy input exists.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0009

- Status: active
- Fact label: Established
- Class: Assumptions or limits
- Role: Direct
- Affected IDs: ASSET-001, ASSET-011, ACTOR-004, ACTOR-005
- Title or description: Maintained trusted-computing-base statement
- Logical locator: component://helium-te-poc/docs/security-and-limits.md
- Revision or checked date: R1
- Observation: Section "Trusted computing base" includes headers and configuration, TE mechanism and fixed policy C, G-stage and runtime C, reset/trap/payload assembly, the privileged CSR/SBI platform boundary, and the linker script. Host report tools, tests and docs are evidence tools, not target TCB.
- Relationship: Direct source for the TCB section.
- Confidence: High
- Confidence basis: Orchestrator read, matches Makefile source lists.
- Alternatives and counter-evidence: QEMU, OpenSBI and toolchains are listed separately as trusted assumptions (E0010).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None material.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0010

- Status: active
- Fact label: Established
- Class: Assumptions or limits
- Role: Direct
- Affected IDs: ASSUMPTION-002, ASSUMPTION-003, ASSUMPTION-004, ACTOR-005
- Title or description: Platform and execution assumptions
- Logical locator: component://helium-te-poc/docs/security-and-limits.md
- Revision or checked date: R1
- Observation: Section "Platform and execution assumptions" assumes QEMU 10.2.2 `virt` with `h=true`, OpenSBI, Bare HS identity mapping, exactly one hart, disabled interrupts, ratified CSR and fence behaviour, correct toolchains and binaries, non-LTO volatile loads, a checked guest layout, no DMA, and non-nested direct trap handling. It states "No assumption is promoted into a proof claim."
- Relationship: Source for the assumptions register and for the trust placed in ACTOR-005.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Assumptions, not verified properties.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0011

- Status: active
- Fact label: Established
- Class: Assumptions or limits
- Role: Direct
- Affected IDs: ASSUMPTION-005, THREAT-007, THREAT-012
- Title or description: Explicit non-goals
- Logical locator: component://helium-te-poc/docs/security-and-limits.md
- Revision or checked date: R1
- Observation: Explicit non-goals include production TE, Linux boot, arbitrary guest containment, universal noninterference, multicore, concurrency, availability, devices, DMA, IOMMU, dynamic policy, attestation, side-channel resistance, stable ABI, certification, and formal verification.
- Relationship: Grounds the out-of-scope dispositions in the coverage matrix.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Scope exclusion is not mitigation.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0012

- Status: active
- Fact label: Established
- Class: Assumptions or limits
- Role: Counter
- Affected IDs: ASSET-002, THREAT-008, MITIGATION-009
- Title or description: API seal is not hardware immutability
- Logical locator: component://helium-te-poc/docs/security-and-limits.md
- Revision or checked date: R1
- Observation: Exact text: "The TE API prevents relabeling after seal, but all HS C is trusted and can write memory if defective or malicious. There is no page-level write protection of policy state and no C memory-safety proof."
- Relationship: Limits the strength of CONTROL-001 against HS-mode defects.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: Policy arrays are ordinary writable HS data (E0032).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0013

- Status: active
- Fact label: Established
- Class: Assumptions or limits
- Role: Direct
- Affected IDs: ASSUMPTION-005, ACTOR-001, ACTOR-002
- Title or description: Subject limitations
- Logical locator: component://helium-te-poc/docs/security-and-limits.md
- Revision or checked date: R1
- Observation: Subjects are sequential synthetic identities, not complete VMs. There is one shared code page, no scheduler, no interrupts or timers, no independent loading, and exactly one one-way writer-to-reader switch.
- Relationship: Bounds actor capabilities and lifecycle.
- Confidence: High
- Confidence basis: Orchestrator read; matches `src/guest.S` and `src/main.c`.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0014

- Status: active
- Fact label: Established
- Class: Assumptions or limits
- Role: Direct
- Affected IDs: THREAT-012, ASSUMPTION-005
- Title or description: Side channels and shared page are outside the result
- Logical locator: component://helium-te-poc/docs/security-and-limits.md
- Revision or checked date: R1
- Observation: Caches, predictors, firmware, QEMU, host scheduling, timing and serial output are outside the result; the shared page is an intentional communication channel.
- Relationship: Supports the out-of-scope disposition of THREAT-012.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0015

- Status: superseded
- Fact label: Established
- Class: Assumptions or limits
- Role: Negative
- Affected IDs: OBJECTIVE-007, ASSUMPTION-001, THREAT-016, MITIGATION-004
- Title or description: No formal verification artefact exists at R1
- Logical locator: component://helium-te-poc/docs/verification.md
- Revision or checked date: R1
- Observation: Section "Exact status" states Helium is "not set up for formal verification" and contains no Rocq/Coq model, Sail H-extension semantics, refinement, CBMC harness, Frama-C/ACSL contract, Cerberus execution, assembly proof, source-to-binary correspondence, or hardware validation.
- Relationship: Any CBMC or formal claim about Helium belongs to a later lineage (E0069) and must not be attributed to R1.
- Confidence: High
- Confidence basis: Orchestrator read and both specialist guard checks.
- Alternatives and counter-evidence: `workspace://formal-verification/helium-te-fv-pathfinder.md` describes later CBMC work on selected properties (E0069).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: none
- Superseded by: TM-20260904-001-E0062

## TM-20260904-001-E0016

- Status: active
- Fact label: Established
- Class: Assumptions or limits
- Role: Direct
- Affected IDs: OBJECTIVE-007, CONTROL-013, ENTRY-008
- Title or description: Supported and prohibited claim wording
- Logical locator: component://helium-te-poc/docs/verification.md
- Revision or checked date: R1
- Observation: Supported wording is limited to: in the fixed single-hart QEMU scenario, host unit tests and repeated GCC and Clang images show two sequential VS subjects receive distinct TE types and G-stage roots, the writer can read and write one shared page, the reader can read but not write it, and each subject's tested access to the other's private page is denied. Listed inaccurate statements include "Helium is formally verified", "The TE policy is proven secure", "The PoC proves noninterference", "The implementation is memory safe", "QEMU proves hardware behavior", and "The hypervisor contains arbitrary guests."
- Relationship: The documented control against claim inflation (CONTROL-013).
- Confidence: High
- Confidence basis: Specialist read verified by orchestrator.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Documentation control only; no technical enforcement.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0017

- Status: active
- Fact label: Established
- Class: Assumptions or limits
- Role: Counter
- Affected IDs: THREAT-013, ASSET-010, CONTROL-010
- Title or description: Retained-evidence boundary admits producer spoofing
- Logical locator: component://helium-te-poc/docs/security-and-limits.md
- Revision or checked date: R1
- Observation: Section "Retained evidence boundary" states retained verification is integrity and correspondence, not authenticity, attestation, measurement, proof, or trust-root verification, and that "An adversarial or compromised producer can create a self-consistent false bundle."
- Relationship: Bounds CONTROL-010 and grounds THREAT-013.
- Confidence: High
- Confidence basis: Specialist read verified by orchestrator.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0018

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: ENTRY-001, FLOW-001, ASSET-001
- Title or description: Boot entry `_start`
- Logical locator: component://helium-te-poc/src/entry.S
- Revision or checked date: R1
- Observation: `_start` preserves the OpenSBI `a0`/`a1` handoff, clears BSS, installs the 8 KiB trusted stack, and calls `he_main`.
- Relationship: First HS instruction sequence on the OpenSBI-to-Helium boundary.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Assumes OpenSBI handoff and identity mapping.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0019

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Counter
- Affected IDs: ENTRY-001, CONTROL-007, THREAT-011, MITIGATION-001
- Title or description: Hart-zero check occurs after shared boot work
- Logical locator: component://helium-te-poc/src/main.c; component://helium-te-poc/src/entry.S
- Revision or checked date: R1
- Observation: `he_main` ignores the FDT pointer and calls `he_fail` when `hartid != 0`. The check executes only after `_start` has already cleared BSS and selected the single shared trusted stack on whichever hart is executing.
- Relationship: CONTROL-007 exists but is not an early multicore-safe gate.
- Confidence: High
- Confidence basis: Orchestrator read of both files.
- Alternatives and counter-evidence: The documented profile is one hart (E0010) and the demo fixes `-smp 1` (E0044), so the race is outside the supported profile.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Behaviour under multiple entering harts is unexercised.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0020

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-006, ENTRY-002, FLOW-001
- Title or description: HS CSR initialisation
- Logical locator: component://helium-te-poc/src/platform.c
- Revision or checked date: R1
- Observation: `he_arch_prepare` writes `stvec` (direct mode to `he_trap_vector`), `sscratch`, Bare `satp`, and zeroes `sie`, `hedeleg`, `hideleg`, `hcounteren`, and `hvip`.
- Relationship: All VS exceptions and interrupts route to HS; no counters are exposed to VS.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: `htimedelta` is not written (E0021).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: CSR effects rely on architecture and QEMU correctness.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0021

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Negative
- Affected IDs: CONTROL-006, MITIGATION-010, OPEN-002
- Title or description: No `htimedelta` initialisation
- Logical locator: component://helium-te-poc/src/platform.c
- Revision or checked date: R1
- Observation: No write to `htimedelta` appears in the privileged C boundary; documentation excludes timer and optional CSR state from the entry-reset contract.
- Relationship: Residual optional-CSR state is not part of the reset baseline.
- Confidence: High
- Confidence basis: Specialist negative search verified by orchestrator read of `platform.c`.
- Alternatives and counter-evidence: `hcounteren = 0` prevents VS `time` access, so the value is unobservable by the guest under the fixed profile.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Negative source observation.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0022

- Status: superseded
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-006, FLOW-002, THREAT-006
- Title or description: VS entry sets HSTATUS SPV, SPVP, VTVM, VTW, VTSR
- Logical locator: component://helium-te-poc/src/entry.S
- Revision or checked date: R1
- Observation: `he_arch_enter_vs` sets `HSTATUS.SPV`, `SPVP`, `VTVM`, `VTW`, and `VTSR` before `SRET` into the writer.
- Relationship: Guest `SATP`/`SFENCE.VMA`, `WFI`, and `SRET` become virtual-instruction traps (cause 22), which are terminal (E0025).
- Confidence: High
- Confidence basis: Orchestrator read; disassembly test asserts the same (E0054).
- Alternatives and counter-evidence: Historical review packages reported these bits cleared; that is stale at R1 (E0060).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Unrelated HSTATUS fields are preserved.
- Supersedes: none
- Superseded by: TM-20260904-001-E0063

## TM-20260904-001-E0023

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Corroborating
- Affected IDs: CONTROL-004, OBJECTIVE-005
- Title or description: Guest entry-state assertion macro
- Logical locator: component://helium-te-poc/src/guest.S
- Revision or checked date: R1
- Observation: Each subject checks its private `sp`, every non-sp GPR being zero, `VSSTATUS.UXL == 2`, and zero in the listed writable VS CSRs before ordinary work; failure reports event 255.
- Relationship: In-image witness of the reset baseline the reader should observe.
- Confidence: High
- Confidence basis: Specialist read verified by orchestrator.
- Alternatives and counter-evidence: A guest cannot read `VSATP` under VTVM, so that CSR is only checked by disassembly test (E0054).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Cooperative payload witness only; a hostile payload would not run it.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0024

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: ENTRY-002, ASSET-001, ASSET-008, CONTROL-004
- Title or description: Trap vector stack exchange and frame save
- Logical locator: component://helium-te-poc/src/trap.S
- Revision or checked date: R1
- Observation: The first instruction of `he_trap_vector` exchanges guest `sp` with `sscratch` (trusted stack) before any memory access, then saves a 240-byte integer frame; the restore path loads the frame and exchanges back before `SRET`.
- Relationship: Guest-controlled `sp` never addresses HS memory operations.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: Nested traps are unsupported; a trap taken while already on the trusted stack would corrupt state (excluded by design, E0010).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0025

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-005, ENTRY-002, THREAT-006, THREAT-007, THREAT-009
- Title or description: Accepted trap causes are exactly 10, 21 and 23
- Logical locator: component://helium-te-poc/src/main.c
- Revision or checked date: R1
- Observation: `he_handle_trap` requires `HSTATUS.SPV` set; it dispatches cause 10 (VS ECALL), 21 (load guest-page fault) and 23 (store/AMO guest-page fault). Every interrupt and every other cause, including 22 (virtual instruction), calls `he_fail`.
- Relationship: The fail-closed core of the trap boundary.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Fixed synthetic protocol; there is no instruction emulation.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0026

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-005, ENTRY-002, FLOW-003, THREAT-003
- Title or description: ECALL event ABI with exact-PC and phase binding
- Logical locator: component://helium-te-poc/src/main.c; component://helium-te-poc/include/he/layout.h; component://helium-te-poc/src/guest.S
- Revision or checked date: R1
- Observation: Event values are writer accesses `1`, writer complete `2`, reader accesses `3`, reader complete `4`, failure `255`. `he_handle_ecall` accepts each value only when `sepc` equals the linked label of that exact ECALL instruction and the active subject and phase match; otherwise `he_fail`.
- Relationship: Blocks out-of-order or forged protocol events.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: Binding depends on linker placement and on the loaded image matching the link (E0028).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Private fixed ABI.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0027

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-005, FLOW-004, THREAT-017
- Title or description: Guest-page-fault recovery requires exact GPA correspondence
- Logical locator: component://helium-te-poc/src/main.c
- Revision or checked date: R1
- Observation: `he_validate_fault_address` requires `HSTATUS.GVA`, `stval == (htval << 2)`, equality with the expected GPA, and exact `sepc`; `he_advance_guest` then adds exactly four bytes (`.option norvc` in `guest.S`).
- Relationship: Fault recovery is accepted only for the two scripted denials.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: The ratified ISA permits `htval` to be zero; such an implementation would terminate at the first scripted denial (fail closed).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: QEMU-specific assumption about `htval` population.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0028

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: ASSET-005, ASSET-006, ASSET-007, ENTRY-003
- Title or description: Fixed guest physical layout in one linked image
- Logical locator: component://helium-te-poc/include/he/layout.h; component://helium-te-poc/src/guest.S
- Revision or checked date: R1
- Observation: Fixed GPAs: code `0x40000000`, writer stack `0x40001000`, reader stack `0x40002000`, writer private `0x40003000`, reader private `0x40004000`, shared `0x40005000`. The guest code is assembled into the same ELF as the monitor.
- Relationship: Defines the memory objects mediated by policy.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Single fixed layout.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0029

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-002, ASSET-003
- Title or description: G-stage leaf encoding and construction checks
- Logical locator: component://helium-te-poc/src/memory.c
- Revision or checked date: R1
- Observation: `he_leaf_pte` pre-sets `V`, `U`, and `A`; writable leaves also pre-set `W` and `D`; `R`/`X` derive from policy. `he_gstage_init`/`he_gstage_map` check table alignment, pairwise table disjointness, table/backing overlap, occupied leaves, and same-root backing aliases. `he_gstage_hgatp` encodes Sv39x4 with VMID 0 for both roots.
- Relationship: Mechanism that turns TE decisions into hardware permissions.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: Historical advice to clear `PTE_U` was rejected by the maintained ledger as reversed (E0061).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Software encoding; hardware walker correctness assumed.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0030

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-001, ASSET-002
- Title or description: TE mechanism and six-rule policy
- Logical locator: component://helium-te-poc/src/te.c; component://helium-te-poc/src/policy/te.c
- Revision or checked date: R1
- Observation: Subject types `monitor_t`, `writer_t`, `reader_t`; six object labels across the six resources. `he_rules[]` holds exactly six allow rules (shared code RX for both subjects, own private RW, writer shared RW, reader shared R), each requiring `open`. Authorisation succeeds only when one rule matches subject, object and every requested permission; there is no rule composition; unmatched requests are denied. Labels are rejected after seal or if duplicated.
- Relationship: The policy control (CONTROL-001).
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: Policy arrays are ordinary writable HS data (E0012). PRV found SELinux accumulates allow masks, so the one-rule semantics are Helium-specific (E0065).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0031

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-002, OBJECTIVE-004, THREAT-010
- Title or description: Policy-derived mapping with PTE readback and cross-private absence check
- Logical locator: component://helium-te-poc/src/main.c
- Revision or checked date: R1
- Observation: `he_mapping_permissions` requires `open`, derives R/W/X individually, rejects empty or write-without-read results, and repeats one combined authorisation. `he_map_or_fail` then compares each TE decision against the stored PTE bits and fails on mismatch. `he_require_private_denial` requires policy denial of `open|read` and absence of the corresponding leaf in the other subject's root.
- Relationship: Initialisation-time reconciliation between policy and enforcement state.
- Confidence: High
- Confidence basis: Orchestrator read; PRV-20260901-001 confirms intent (E0066).
- Alternatives and counter-evidence: Readback reads software page-table memory in the same trust domain as the mapper; it is not HGATP or TLB readback (E0066).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: One-time check before activation.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0032

- Status: superseded
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-003, CONTROL-004, FLOW-006, THREAT-004, THREAT-005
- Title or description: Writer-to-reader switch sequence
- Logical locator: component://helium-te-poc/src/main.c; component://helium-te-poc/src/platform.c; component://helium-te-poc/include/he/runtime.h
- Revision or checked date: R1
- Observation: `he_switch_to_reader` changes subject and phase, sets the reader PC, clears the saved trap frame, resets VS CSRs, executes `HFENCE.VVMA`, writes the reader `hgatp`, executes `HFENCE.GVMA` (all addresses, all VMIDs), then writes the reader stack to `sscratch`. The unchanged restore path loads the zeroed frame and exchanges onto the reader stack before `SRET`.
- Relationship: The only privilege transition between subjects.
- Confidence: High
- Confidence basis: Orchestrator read; disassembly test asserts ordering (E0054).
- Alternatives and counter-evidence: Optional-extension, timing and microarchitectural state are not reset (E0014, E0021).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: One-way transition only.
- Supersedes: none
- Superseded by: TM-20260904-001-E0066

## TM-20260904-001-E0033

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: ENTRY-004, FLOW-005, CONTROL-005
- Title or description: HS reads guest sentinels through volatile loads
- Logical locator: component://helium-te-poc/src/memory.c; component://helium-te-poc/src/main.c
- Revision or checked date: R1
- Observation: HS observation of guest-mutated sentinel values uses a `const volatile` load helper (`he_guest_load_u64`); cause 23 acceptance additionally requires the shared value to be unchanged and the leaf present, readable and non-writable.
- Relationship: HS consumes guest-writable memory as data only.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: Compiler observability, not hardware coherence (E0055).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: LTO excluded by build assumption.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0034

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: ASSET-009, FLOW-007, CONTROL-008, BOUNDARY-001
- Title or description: SBI usage, result markers and shutdown path
- Logical locator: component://helium-te-poc/src/platform.c; component://helium-te-poc/src/main.c
- Revision or checked date: R1
- Observation: Helium uses legacy SBI console putchar and system-reset shutdown (falling back to legacy shutdown). Guest ECALLs are not proxied to SBI. `he_fail` emits `HE_RESULT: FAIL`, requests shutdown, and spins in `WFI` if firmware returns; success emits `HE_RESULT: PASS` before the same shutdown path.
- Relationship: Only guest-to-world output channel is through HS; the terminal marker is HS-owned.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: OpenSBI is trusted; no availability guarantee.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0035

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Counter
- Affected IDs: THREAT-008, ASSET-001, MITIGATION-005
- Title or description: Target C is built with `-fno-stack-protector`
- Logical locator: component://helium-te-poc/Makefile
- Revision or checked date: R1
- Observation: `HE_MAKEFILE_TARGET_FLAGS` builds freestanding, warning-strict C with `-fno-stack-protector`; no stack guard page or canary is present in the target image.
- Relationship: No runtime detection of trusted-stack overflow.
- Confidence: High
- Confidence basis: Orchestrator read of Makefile.
- Alternatives and counter-evidence: The maintained ledger rejected earlier stack-protector findings as not applicable to the freestanding profile (E0061); the trap frame is fixed-size and HS code has no recursion.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: No C memory-safety proof exists (E0012).
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0036

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-014, ASSET-011, ENTRY-005, FLOW-009
- Title or description: Build-graph and output confinement
- Logical locator: component://helium-te-poc/Makefile; component://helium-te-poc/he
- Revision or checked date: R1
- Observation: Production sources, sole policy, linker script, flags, tools and canonical outputs are Makefile-owned; negative payloads use explicit internal targets and disjoint roots; `he_validate_output_paths` confines outputs under canonical `build/` and rejects symlink, dot, parent and escaping components. The `he` wrapper rejects extra arguments for every command except `evidence-check`.
- Relationship: Host-side integrity of the image build.
- Confidence: High
- Confidence basis: Specialist read verified by orchestrator.
- Alternatives and counter-evidence: Validation is not race-free against a hostile concurrent host actor; arbitrary replacement Make rules are outside the boundary.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Host filesystem and tools remain trusted.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0037

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: ENTRY-005, ACTOR-005, ASSUMPTION-003
- Title or description: Demo environment inputs and fixed QEMU invocation
- Logical locator: component://helium-te-poc/scripts/demo.sh; component://helium-te-poc/scripts/tool-paths.sh
- Revision or checked date: R1
- Observation: `HE_TOOLCHAIN`, `QEMU`, and `HE_OPENSBI_FIRMWARE` are accepted; executables may resolve through `PATH`. QEMU runs `-machine virt -cpu rv64,h=true -smp 1 -m 128M`, no display or monitor, serial on stdio, packaged firmware, `-no-reboot`.
- Relationship: Operator-controlled inputs that select the trusted platform binaries.
- Confidence: High
- Confidence basis: Specialist read verified by orchestrator.
- Alternatives and counter-evidence: Version enforcement (QEMU 10.2.2) occurs in `check-tools.sh`, not in the demo wrapper.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0038

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-014, ASSET-011, THREAT-014
- Title or description: Evaluator container and Node dependency pinning
- Logical locator: component://helium-te-poc/Containerfile; component://helium-te-poc/package.json; component://helium-te-poc/package-lock.json
- Revision or checked date: R1
- Observation: The evaluator image uses a digest-pinned Fedora base and installs cross-toolchains, QEMU, Git, Graphviz, Node/npm, Chromium and Make from distribution repositories, recording installed provenance. `package.json` declares exactly two direct dev dependencies (`playwright-core` 1.61.1, `vitepress` 1.6.4); lockfile v3 pins transitive packages with integrity hashes.
- Relationship: Supply-chain surface of the evidence and documentation tooling.
- Confidence: High
- Confidence basis: Specialist read verified by orchestrator.
- Alternatives and counter-evidence: Networked image build and mutable repositories remain trusted; the full transitive count was not derived.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0039

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-012, ENTRY-007, FLOW-010, ASSET-010
- Title or description: Publication gate is blocked
- Logical locator: component://helium-te-poc/publication-gate.conf
- Revision or checked date: R1
- Observation: `status=blocked`; reviewed-commit and review-time fields are empty.
- Relationship: No public release is authorised at R1.
- Confidence: High
- Confidence basis: Orchestrator read.
- Alternatives and counter-evidence: `docs/policy-and-publication.md` separately authorises review-only posting; that is not release approval (E0040).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0040

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-012, ENTRY-007, THREAT-015, ACTOR-008
- Title or description: Gate checker is structural, not cryptographic
- Logical locator: component://helium-te-poc/scripts/check-publication-gate.sh; component://helium-te-poc/docs/policy-and-publication.md
- Revision or checked date: R1
- Observation: Approval requires exact committed bytes, fixed unique fields, `approved` status, a full lowercase 40-hex commit, strict UTC time, clean matching index and worktree, no replacement/graft/shallow state, a one-parent gate commit, and only `publication-gate.conf` changed from the reviewed parent. Policy text assigns reviewer and publisher authority to the responsible human and states automation cannot claim review or release approval.
- Relationship: Identity of the approving human is procedural, not authenticated by the checker.
- Confidence: High
- Confidence basis: Specialist read verified against orchestrator read of the checker.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0041

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: ENTRY-009, THREAT-018
- Title or description: Documentation preview server defaults
- Logical locator: component://helium-te-poc/scripts/serve-docs.mjs; component://helium-te-poc/tests/test-serve-docs.mjs
- Revision or checked date: R1
- Observation: The built-in server binds loopback by default, permits only GET/HEAD, canonicalises the generated root, and rejects malformed paths, dot segments, backslashes, root escape and escaping symlinks; remote bind requires explicit opt-in.
- Relationship: Only network listener in the repository.
- Confidence: High
- Confidence basis: Specialist read.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Host Node runtime trusted.
- Supersedes: none
- Superseded by: none

## Tier 3 and 4: reviews, tests and assurance records (R1)

## TM-20260904-001-E0042

- Status: active
- Fact label: Established
- Class: Implementation or test evidence
- Role: Corroborating
- Affected IDs: CONTROL-001, CONTROL-002
- Title or description: Host unit tests and authority report
- Logical locator: component://helium-te-poc/tests/unit/test_main.c; component://helium-te-poc/tools/authority-report.c; component://helium-te-poc/tests/check-authority-reports.mjs
- Revision or checked date: R1
- Observation: Host unit tests exercise trap-frame clearing, TE reset/label/seal/authorisation, the six rules, malformed and default denials, two G-stage roots, overlap and alias rejection, and shared asymmetry. The authority report emits three subjects, six resources, six rules, eight derived mappings and 48 individual decisions; the checker requires exact values and ordering.
- Relationship: Evidence that CONTROL-001 and CONTROL-002 behave as specified under host compilation.
- Confidence: High
- Confidence basis: Specialist read of the test sources.
- Alternatives and counter-evidence: Host execution does not establish privileged hardware behaviour.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Not executed in this engagement.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0043

- Status: active
- Fact label: Established
- Class: Implementation or test evidence
- Role: Direct
- Affected IDs: CONTROL-008, ASSET-009, FLOW-008, ENTRY-006
- Title or description: QEMU trace protocol and exact-once validator
- Logical locator: component://helium-te-poc/tests/run-qemu.sh; component://helium-te-poc/tests/validate-qemu-trace.sh
- Revision or checked date: R1
- Observation: Each GCC and Clang image defaults to three bounded QEMU runs; each run must contain exact build/model metadata and twelve stage/test/result markers exactly once and in order, with no `FAIL`. Records include toolchain, ELF hash, QEMU path/version/hash, firmware path/version/hash. Architecture documentation states VS cannot emit serial output because ECALL is not delegated.
- Relationship: The PASS marker can be produced only by HS or by the host tooling that captures it.
- Confidence: High
- Confidence basis: Orchestrator read of the validator; specialist read of the runner.
- Alternatives and counter-evidence: A compromised evidence producer can fabricate a consistent log (E0017).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Finite marker protocol.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0044

- Status: active
- Fact label: Established
- Class: Implementation or test evidence
- Role: Direct
- Affected IDs: CONTROL-009, THREAT-003, THREAT-006
- Title or description: Six negative payload images and negative validator
- Logical locator: component://helium-te-poc/tests/negative; component://helium-te-poc/tests/test-negative-qemu-images.sh; component://helium-te-poc/tests/validate-negative-qemu-trace.sh
- Revision or checked date: R1
- Observation: Early-completion and skip-writer-denial payloads expect terminal "unexpected writer completion event". `SATP`, `SFENCE.VMA`, `SRET` and `WFI` payloads expect exact cause-22 reporting then common terminal failure without emulation. Each payload is linked alone under both toolchains in a distinct root, must use four-byte instructions, and must leave canonical production hashes unchanged. The negative validator forbids `PASS`, requires exact trap PC where applicable, and rejects post-terminal markers.
- Relationship: Test evidence for the fail-closed behaviour of CONTROL-005 and CONTROL-006.
- Confidence: High
- Confidence basis: Specialist read verified against orchestrator read of `docs/architecture.md`.
- Alternatives and counter-evidence: Six selected cases; no adversarial fuzzing.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: QEMU-only.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0045

- Status: active
- Fact label: Established
- Class: Implementation or test evidence
- Role: Corroborating
- Affected IDs: CONTROL-003, CONTROL-004, CONTROL-006
- Title or description: Subject entry-state disassembly test
- Logical locator: component://helium-te-poc/tests/test-subject-entry-state.sh
- Revision or checked date: R1
- Observation: Source and disassembly checks require zero in all non-sp GPRs, private `sp`, the fixed VS-CSR baseline, Bare `VSATP` plus `HFENCE.VVMA`, VT controls set, and the exact `hgatp`/`HFENCE.GVMA`/stack/restore ordering in both toolchain images.
- Relationship: Build-time witness of the switch sequence and reset baseline.
- Confidence: High
- Confidence basis: Specialist read.
- Alternatives and counter-evidence: Optional CSRs and microarchitectural state not covered.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Not executed here.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0046

- Status: active
- Fact label: Established
- Class: Implementation or test evidence
- Role: Corroborating
- Affected IDs: CONTROL-005, CONTROL-014
- Title or description: Memory and build assurance test
- Logical locator: component://helium-te-poc/tests/test-memory-build-assurance.sh
- Revision or checked date: R1
- Observation: Host tier checks build-tag validation, anti-`NDEBUG`, GPA layout and report capacity; target tier checks eight volatile sentinel calls and emitted loads, corrupt-sentinel failure, and BSS alignment guards for GNU ld and lld.
- Relationship: Evidence that volatile loads survive compilation.
- Confidence: High
- Confidence basis: Specialist read.
- Alternatives and counter-evidence: Compiler observability is not hardware coherence.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Not executed here.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0047

- Status: active
- Fact label: Established
- Class: Implementation or test evidence
- Role: Direct
- Affected IDs: CONTROL-010, ASSET-010, FLOW-008, ENTRY-006
- Title or description: Evidence generation, contract and read-only verifier
- Logical locator: component://helium-te-poc/tests/generate-evidence.sh; component://helium-te-poc/tests/verify-evidence.sh; component://helium-te-poc/scripts/evidence-contract.sh; component://helium-te-poc/tests/test-evidence-verifier.sh
- Revision or checked date: R1
- Observation: Generation distinguishes exact-clean from `dirty-development`, hashes source, documentation and artefact manifests, records QEMU and tool identities, and publishes transactionally. The verifier requires an exact clean commit, rejects dirty or abbreviated source, validates commit bytes, modes, hashes, authority semantics, exact traces, run counts, and independently selected QEMU/OpenSBI identities. Fixtures cover tampering, path and symlink escape, and rollback.
- Relationship: Correspondence control between commit and evidence bundle.
- Confidence: High
- Confidence basis: Specialist read.
- Alternatives and counter-evidence: Integrity and correspondence only (E0017).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Not executed here; committed bundle bytes were not verified.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0048

- Status: active
- Fact label: Established
- Class: Implementation or test evidence
- Role: Direct
- Affected IDs: CONTROL-011, BOUNDARY-004, ACTOR-006
- Title or description: Rootless evaluator boundary
- Logical locator: component://helium-te-poc/tests/run-rootless.sh; component://helium-te-poc/scripts/evaluator-boundary.sh; component://helium-te-poc/tests/test-rootless-runner.sh
- Revision or checked date: R1
- Observation: Rootless evaluation uses private locked Podman state, a captured immutable image ID, read-only `/source`, rootfs and provenance, a writable copied `/work`, bounded `/export`, hidden read-only tmpfs overlays over `node_modules`, `build` and logs, no network or proxy, no capabilities and no-new-privileges.
- Relationship: Containment of evaluation tooling from the source checkout.
- Confidence: High
- Confidence basis: Specialist read.
- Alternatives and counter-evidence: Podman, kernel, OCI runtime and networked image build remain trusted.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Not executed here.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0049

- Status: active
- Fact label: Established
- Class: Security or assurance review process
- Role: Direct
- Affected IDs: THREAT-013, MITIGATION-007
- Title or description: Review provenance contract and its attestation limit
- Logical locator: component://helium-te-poc/agent-review/REVIEW-PROVENANCE.md; component://helium-te-poc/tests/lint-review-manifest.mjs
- Revision or checked date: R1
- Observation: The contract distinguishes `static-only` from `execution-backed`, requires exact source state, commands, tools, exit results and retained evidence hashes for future packages, and states the manifest "is an attestation by the package producer" that does not prove a command ran or that the declared model produced the reports. The linter enforces schema, cross-field semantics and SHA-256 matches.
- Relationship: Defines what review provenance can and cannot establish.
- Confidence: High
- Confidence basis: Orchestrator read of `REVIEW-PROVENANCE.md`.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Explicitly non-retroactive.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0050

- Status: active
- Fact label: Established
- Class: Security or assurance review
- Role: Contextual
- Affected IDs: THREAT-016, ASSUMPTION-006
- Title or description: Five historical AI review packages predate provenance and target other commits
- Logical locator: component://helium-te-poc/agent-review; component://helium-te-poc/docs/review-remediation.md
- Revision or checked date: R1; package baselines 8e594dfb…, e0babc2c…, 3292aa64…, 9b2c407, d759b4d
- Observation: The remediation ledger states all five retained packages predate the provenance contract and lack verified package-specific execution provenance. Each package's recorded baseline differs from R1. One package's headers name one model while the ledger reports its commit trailer names another.
- Relationship: Historical review conclusions are self-attested inputs, not evidence about R1.
- Confidence: High
- Confidence basis: Specialist read of package READMEs and ledger.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Model identity and independence of the packages are not established.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0051

- Status: active
- Fact label: Established
- Class: Security or assurance review
- Role: Corroborating
- Affected IDs: THREAT-004, THREAT-008, THREAT-015
- Title or description: Recurring historical findings
- Logical locator: component://helium-te-poc/agent-review/claude-fable-5/03-findings.md; component://helium-te-poc/agent-review/claude-opus-5/03-findings.md; component://helium-te-poc/agent-review/grok-4.5/03-findings.md; component://helium-te-poc/agent-review/gemini-3.1-pro-preview/03-findings.md
- Revision or checked date: historical baselines listed in E0050
- Observation: GPR residue across the writer-to-reader switch recurs in three packages (two also report VS-CSR residue); non-reentrant HS trap handling recurs in three; read/write evaluator checkout exposure recurs in three; publication identity weakness recurs in two. Distinct surfaces include volatile sentinel loads, duplicate-marker checking, optional `HTVAL`, VT-control clearing, and `HTINST`.
- Relationship: Independent prior identification of surfaces modelled here; most have R1 controls.
- Confidence: Medium
- Confidence basis: Specialist read; content is AI-generated historical review.
- Alternatives and counter-evidence: Frame clear, CSR reset, exact-once validator, VT controls and read-only `/source` exist at R1 (E0022, E0032, E0043, E0048).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Severities and recommendations were not adopted.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0052

- Status: active
- Fact label: Established
- Class: Security or assurance review
- Role: Direct
- Affected IDs: MITIGATION-006, THREAT-015, THREAT-010, ASSUMPTION-006
- Title or description: Remediation ledger dispositions and human checkpoints
- Logical locator: component://helium-te-poc/docs/review-remediation.md
- Revision or checked date: R1
- Observation: The ledger says all 15 canonical technical actions are implemented; it rejects or narrows `PTE_U` removal (accessible G-stage leaves require `U=1`), the VSATP exact-PC bypass, mandatory `HTINST`, current stack-overflow claims, PIE/stack-protector findings, and mandatory attestation. H1–H5 decisions are recorded; H6 (exact clean-commit source review) and H7 (release approval) remain incomplete. The opening paragraph still calls the integration an "uncommitted worktree", which is stale at the clean R1 commit.
- Relationship: Current disposition state of prior review findings and the human gates.
- Confidence: High
- Confidence basis: Specialist read verified by orchestrator sampling.
- Alternatives and counter-evidence: Dispositions are automation-produced; no responsible-human H6 record exists.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Implementation status is not approval.
- Supersedes: none
- Superseded by: none

## Tier 1, 5 and 6: parent coordination, PRV and AWB packages, research

## TM-20260904-001-E0053

- Status: active
- Fact label: Established
- Class: Parent coordination
- Role: Direct
- Affected IDs: ASSUMPTION-001, OBJECTIVE-007
- Title or description: Parent assurance status wording
- Logical locator: workspace://HANDOFF.md; workspace://COMPONENTS.md
- Revision or checked date: W
- Observation: Beryllium is accepted through R7; R8-H0 is a committed candidate and is not accepted; K3 hardware is `NOT RUN`. Helium is a review-and-test PoC, not formally verified, not hardware validated; selected C properties may be described as machine-checked by CBMC only within their exact boundaries. Helium supplies a small executable TE monitor and bounded-verification pathfinder; Beryllium consumes it as supporting evidence.
- Relationship: Assurance ceiling and component relationship for this model.
- Confidence: High
- Confidence basis: Specialist read of parent records.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Coordination records, not component behaviour.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0054

- Status: active
- Fact label: Established
- Class: Completed PRV package
- Role: Direct
- Affected IDs: CONTROL-001, ASSUMPTION-007
- Title or description: PRV-20260828-001 complete for R1; SELinux composition counter-evidence
- Logical locator: component://provenance-review/reviews/PRV-20260828-001-helium-te-security-architecture/HANDOFF.md; component://provenance-review/reviews/PRV-20260828-001-helium-te-security-architecture/report.md
- Revision or checked date: d698e7598e44928e4a64d7ebc3de7655cfbefb29 (committed state; dirty overlay excluded)
- Observation: The review is complete for exact Helium commit `1ab289c…` and identifies Beryllium `511187f…` as the earliest internal predecessor. Primary SELinux evidence showed ordinary matching allow masks are accumulated, contradicting inheritance of Helium's one-rule non-composition. No inspected primary source matched the complete synchronous policy-derivation, PTE-encoding, readback and terminal-divergence sequence. Promotion is blocked by private target evidence and absent human record.
- Relationship: Establishes that the one-rule semantics of CONTROL-001 are Helium-specific and unreviewed against an external precedent.
- Confidence: High
- Confidence basis: Specialist read of completed package.
- Alternatives and counter-evidence: Bounded negative result; inaccessible sources remain.
- Sensitivity: private
- Redistribution: not-approved
- Hash: not-applicable
- Limitations: Provenance review, not security analysis.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0055

- Status: active
- Fact label: Established
- Class: Completed PRV package
- Role: Counter
- Affected IDs: CONTROL-002, THREAT-010, MITIGATION-002
- Title or description: PRV-20260901-001: readback limits
- Logical locator: component://provenance-review/reviews/PRV-20260901-001-policy-install-readback/HANDOFF.md; component://provenance-review/reviews/PRV-20260901-001-policy-install-readback/assurance-practices.md
- Revision or checked date: d698e7598e44928e4a64d7ebc3de7655cfbefb29
- Observation: Readback was an intentional initialisation-time policy-to-PTE soundness check present before independent review. The comparison reads stored software page-table memory; it is not HGATP readback, effective TLB state, continuous monitoring, or an independent trust domain. Mapper and checker share policy APIs, PTE constants, compiler, image, memory and trust domain; post-check mutation and correlated errors remain possible. No maintained direct divergence test was identified.
- Relationship: Bounds the effectiveness of CONTROL-002.
- Confidence: High
- Confidence basis: Specialist read of completed package, consistent with orchestrator read of `he_map_or_fail`.
- Alternatives and counter-evidence: None.
- Sensitivity: private
- Redistribution: not-approved
- Hash: not-applicable
- Limitations: Proposed mitigations in the PRV are not current controls.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0056

- Status: active
- Fact label: Established
- Class: Completed AWB package
- Role: Counter
- Affected IDs: CONTROL-003, THREAT-005, ASSUMPTION-004
- Title or description: AWB-20260829-001: selector equality versus stale translations
- Logical locator: component://analysis-workbook/sessions/AWB-20260829-001-post-g-install-readback-use-case/inquiries/Q-001/summary.md
- Revision or checked date: 2261659
- Observation: Selector (`hgatp`) equality is consistent with stale translations. The bounded same-VMID case depends on `V=0` leaves and the all-address, all-VMID `HFENCE.GVMA`, not on readback. One-time readback does not close stale CPU/IOMMU state, later mutation, DMA, debug, replay or rollback. QEMU observations are not K3 hardware evidence.
- Relationship: Identifies the fence, not readback, as the control against cross-subject stale translation.
- Confidence: Medium
- Confidence basis: Completed analysis session; medium-confidence per its own record; Beryllium-oriented.
- Alternatives and counter-evidence: Helium has no IOMMU, DMA or later mutation, so only the CPU translation-cache case applies.
- Sensitivity: private
- Redistribution: not-approved
- Hash: not-applicable
- Limitations: Beryllium-specific analysis applied by analogy.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0057

- Status: active
- Fact label: Established
- Class: Historical transcript
- Role: Counter
- Affected IDs: THREAT-008, ASSUMPTION-007
- Title or description: TE was not considered an isolation mechanism by itself
- Logical locator: component://beryllium-repo/planning/session-analysis-te-vbs-2026-07-20.md
- Revision or checked date: R2
- Observation: The transcript records that code in one HS address space could bypass TE or overwrite its state; separate hardware-enforced roots, private CPU state, controlled gates and fault containment were required. Fixed TE was viewed as verification-feasible because it is finite, static, deterministic, allocation-free and default-deny.
- Relationship: Design rationale confirming that HS-mode integrity, not TE, is the root of isolation.
- Confidence: Medium
- Confidence basis: Retrospective agent-generated transcript; redistribution unknown.
- Alternatives and counter-evidence: Transcripts postdate the fixed-TE checkpoint and cannot establish original intent.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Research judgment, not proof.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0058

- Status: active
- Fact label: Established
- Class: Formal-verification research
- Role: Contextual
- Affected IDs: MITIGATION-004, THREAT-016
- Title or description: CBMC boundedness and the later Helium FV lineage
- Logical locator: component://formal-verification-research/notes/fv-primer-and-tooling.md; workspace://formal-verification/helium-te-fv-pathfinder.md; component://formal-verification-research/workstreams/beryllium/strategy.md
- Revision or checked date: 8b91ebda1d4a5c733596a67ef7c5cc83486212e9; W
- Observation: CBMC results are bounded by unwind depth and are complete only when the bound provably covers program bounds. Later Helium FV work used explicit unwind bounds with unwinding assertions, independent specifications, no `__CPROVER_assume`, and mutation checks for selected fixed-profile C properties. Multicore, interrupts, DMA/IOMMU, dynamic policy and device models are identified as a scaling cliff for the finite-state argument.
- Relationship: Defines what a bounded-model-checking mitigation could and could not establish; none of it applies to R1 (E0015).
- Confidence: High
- Confidence basis: Specialist read of research and parent records.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Later lineage is outside the frozen target commit.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0059

- Status: active
- Fact label: Established
- Class: Partial or embedded model
- Role: Contextual
- Affected IDs: ACTOR-003, ACTOR-007, ACTOR-009
- Title or description: Historical four-model framing in one review package
- Logical locator: component://helium-te-poc/agent-review/grok-4.5/01-scope-methodology.md
- Revision or checked date: historical 9b2c407
- Observation: The package frames four threat models: fixed cooperative payload, adversarial linked payload, host evaluator/developer workstation, and process/assurance misuse; asserted assets include monitor integrity, policy/PTE correspondence, private pages, shared-page asymmetry, evidence integrity and publication controls.
- Relationship: Prior framing compared against, not adopted by, this model's actor set.
- Confidence: Medium
- Confidence basis: AI-generated historical review.
- Alternatives and counter-evidence: Not a maintained model (E0003).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Reviewed a different commit.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0060

- Status: active
- Fact label: Established
- Class: Registered research
- Role: Contextual
- Affected IDs: ASSUMPTION-003, ASSUMPTION-004, THREAT-005
- Title or description: Emulator evidence and H-extension implementation dependence
- Logical locator: component://xrv-research-repo/riscv-hypervisors-research-stream.md; component://xrv-research-repo/review-done/supervisor-domain-isolation-smmtt.md
- Revision or checked date: ca414903b93cab82697a30ec2a57ed62c357d380
- Observation: RISC-V H, AIA and IOMMU define enabling mechanisms; hypervisor security depends on implementation-specific G-stage, SBI/CSR emulation, interrupt, timer, device and lifecycle handling. QEMU TCG observations are emulator evidence, not hardware deployment evidence. Deployment analysis must separately cover invalidation ordering, identifier reuse, reclaim/zeroing and revocation.
- Relationship: Supports the emulator-boundary assumption and the stale-translation threat framing.
- Confidence: Medium
- Confidence basis: Preliminary research stream; not primary sources.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: No `hstatus`/`hedeleg` clause analysis.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0061

- Status: active
- Fact label: Unknown
- Class: Redistribution status
- Role: Negative
- Affected IDs: ASSUMPTION-008
- Title or description: Transcript redistribution permission not recorded
- Logical locator: component://beryllium-repo/planning/session-analysis-transcripts-2026-07-20.md
- Revision or checked date: R2
- Observation: The index records how transcripts were recovered and that they are verbatim, but records no redistribution permission.
- Relationship: Blocks any promotion beyond `private` while transcript-derived evidence is cited.
- Confidence: High
- Confidence basis: Specialist negative search.
- Alternatives and counter-evidence: None.
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0062

- Status: active
- Fact label: Established
- Class: Assumptions or limits
- Role: Negative
- Affected IDs: OBJECTIVE-007, ASSUMPTION-001, THREAT-016, MITIGATION-004
- Title or description: No formal verification artefact exists at R1 (corrected cross-references)
- Logical locator: component://helium-te-poc/docs/verification.md
- Revision or checked date: R1
- Observation: Section "Exact status" states Helium is "not set up for formal verification" and contains no Rocq/Coq model, Sail H-extension semantics, refinement, CBMC harness, Frama-C/ACSL contract, Cerberus execution, assembly proof, source-to-binary correspondence, or hardware validation.
- Relationship: Any CBMC or formal claim about Helium belongs to a later lineage (E0058) and must not be attributed to R1. This record supersedes E0015 solely to correct a dangling reference to a never-allocated evidence ID (`E0069`); the observation is unchanged (review FINDING-003).
- Confidence: High
- Confidence basis: Orchestrator read and both specialist guard checks.
- Alternatives and counter-evidence: `workspace://formal-verification/helium-te-fv-pathfinder.md` describes later CBMC work on selected properties (E0058).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: None.
- Supersedes: TM-20260904-001-E0015
- Superseded by: none

## TM-20260904-001-E0063

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-006, FLOW-002, THREAT-006
- Title or description: VS entry sets HSTATUS SPV, SPVP, VTVM, VTW, VTSR (corrected cross-references)
- Logical locator: component://helium-te-poc/src/entry.S
- Revision or checked date: R1
- Observation: `he_arch_enter_vs` sets `HSTATUS.SPV`, `SPVP`, `VTVM`, `VTW`, and `VTSR` before `SRET` into the writer.
- Relationship: Guest `SATP`/`SFENCE.VMA`, `WFI`, and `SRET` become virtual-instruction traps (cause 22), which are terminal (E0025). Supersedes E0022 to correct its cross-references: the disassembly test is E0045 (not E0054) and the stale historical findings are E0051 (not E0060) (review FINDING-003).
- Confidence: High
- Confidence basis: Orchestrator read; the subject entry-state disassembly test is designed to assert the same bits (E0045).
- Alternatives and counter-evidence: Historical review packages reported these bits cleared; that is stale at R1 (E0051).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: Unrelated HSTATUS fields are preserved.
- Supersedes: TM-20260904-001-E0022
- Superseded by: none

## TM-20260904-001-E0064

- Status: active
- Fact label: Established
- Class: Public secondary source
- Role: Corroborating
- Affected IDs: CONTROL-003, THREAT-005, ASSUMPTION-004, OPEN-001
- Title or description: `HFENCE.GVMA` with rs1=x0 and rs2=x0 orders/invalidates for all guest-physical addresses and all VMIDs (secondary summaries of the RISC-V Privileged Architecture hypervisor chapter)
- Logical locator: https://docs.riscv.org/reference/isa/priv/hypervisor.html; https://five-embeddev.com/riscv-priv-isa-manual/Priv-v1.12/hypervisor.html; https://riscv.github.io/riscv-unified-db/manual/html/isa/isa_20240411/insts/hfence.gvma.html
- Revision or checked date: Privileged Architecture v1.12 (ratified hypervisor extension); checked 2026-09-04 via an AI-mediated search summary
- Observation: The returned summaries consistently state that when both `rs1` and `rs2` are `x0`, `HFENCE.GVMA` applies to all guest-physical addresses and all VMIDs. The primary documents themselves could not be fetched (BLOCKED-001).
- Relationship: Corroborates that the switch-sequence fence in FLOW-006 is the all-VMID form the source intends; answers OPEN-001 at specification level only.
- Confidence: Medium
- Confidence basis: Secondary summaries only; consistent across several independent mirrors; not read in the primary text.
- Alternatives and counter-evidence: An implementation could fail to honour the fence (ASSUMPTION-003); hardware `NOT RUN`.
- Sensitivity: public
- Redistribution: approved
- Hash: not-applicable
- Limitations: Secondary source; exact clause text not retained.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0065

- Status: active
- Fact label: Established
- Class: Public secondary source
- Role: Corroborating
- Affected IDs: THREAT-017, CONTROL-005, OPEN-006
- Title or description: Privileged Architecture v1.12 permits `htval` to be written as zero when the faulting guest-physical address is not known
- Logical locator: https://docs.riscv.org/reference/isa/priv/hypervisor.html; https://five-embeddev.com/riscv-priv-isa-manual/Priv-v1.12/hypervisor.html
- Revision or checked date: Privileged Architecture v1.12, hypervisor chapter, `htval` section; checked 2026-09-04 via an AI-mediated search summary
- Observation: Summaries state that on a guest-page fault `htval` is written with either zero or the faulting guest-physical address shifted right by two, and that if the address is not known it is written with zero. Primary text could not be fetched (BLOCKED-001).
- Relationship: Establishes that THREAT-017 is a genuine portability limit of the exact-GPA validation in `he_validate_fault_address`, not a modelling artefact.
- Confidence: Medium
- Confidence basis: Secondary summaries only; consistent with the target's own documentation limit (E0027).
- Alternatives and counter-evidence: None found.
- Sensitivity: public
- Redistribution: approved
- Hash: not-applicable
- Limitations: Secondary source; exact clause text not retained.
- Supersedes: none
- Superseded by: none

## TM-20260904-001-E0066

- Status: active
- Fact label: Established
- Class: Implementation evidence
- Role: Direct
- Affected IDs: CONTROL-003, CONTROL-004, FLOW-006, THREAT-004, THREAT-005
- Title or description: Writer-to-reader switch sequence (corrected cross-references)
- Logical locator: component://helium-te-poc/src/main.c; component://helium-te-poc/src/platform.c; component://helium-te-poc/include/he/runtime.h
- Revision or checked date: R1
- Observation: `he_switch_to_reader` changes subject and phase, sets the reader PC, clears the saved trap frame, resets VS CSRs, executes `HFENCE.VVMA`, writes the reader `hgatp`, executes `HFENCE.GVMA` (all addresses, all VMIDs), then writes the reader stack to `sscratch`. The unchanged restore path loads the zeroed frame and exchanges onto the reader stack before `SRET`.
- Relationship: The only privilege transition between subjects. Supersedes E0032 to correct its cross-reference: the disassembly test is E0045 (not E0054).
- Confidence: High
- Confidence basis: Orchestrator read; the disassembly test is designed to assert ordering (E0045).
- Alternatives and counter-evidence: Optional-extension, timing and microarchitectural state are not reset (E0014, E0021).
- Sensitivity: internal
- Redistribution: unknown
- Hash: not-applicable
- Limitations: One-way transition only.
- Supersedes: TM-20260904-001-E0032
- Superseded by: none

## TM-20260904-001-E0067

- Status: active
- Fact label: Established
- Class: Engagement record
- Role: Contextual
- Affected IDs: FINDING-001, FINDING-002, FINDING-003, FINDING-004, FINDING-005, FINDING-006, FINDING-007, FINDING-008, FINDING-009, FINDING-010, FINDING-011, FINDING-012, FINDING-013
- Title or description: Independent review pass over the frozen draft projection
- Logical locator: workspace://threat-modeler/models/TM-20260904-001-helium-te-poc-fable51/review.md
- Revision or checked date: 2026-09-04
- Observation: A write-disabled `threat-model-review` specialist reviewed the frozen `threat-model.md`, `evidence-ledger.md`, `open-questions.md` and DOT sources; its target-state guard (`HEAD` = `ref: refs/heads/for-review`, packed ref `1ab289c066b69acdd8b55c9f77055b0145be1316`) passed at start and end. It returned thirteen provisional findings, transcribed by the orchestrator as FINDING-001 to FINDING-013.
- Relationship: Input to the corrections recorded in MODEL-ITERATION-001 and REVIEW-ITERATION-001.
- Confidence: High
- Confidence basis: Orchestrator transcription of specialist output.
- Alternatives and counter-evidence: Specialist output is review input, not authority.
- Sensitivity: private
- Redistribution: not-applicable
- Hash: not-applicable
- Limitations: Single review pass; no second reviewer.
- Supersedes: none
- Superseded by: none
