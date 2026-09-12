# Open questions

Package ID: `TM-20260911-001`
Title: Helium TE PoC Independent Threat Model (GPT-6 Astra)
Created: 2026-09-11
Status: `Complete`
Distribution: `private`

| Open ID | Blocking | Question | Why it matters | Assumption in use | Answer | Evidence IDs | Status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| OPEN-001 | Blocking at intake; resolved | Are both registered Helium and historical Beryllium views owner-prepared and stable throughout specialist reads? | Read-only specialists cannot manufacture frozen checkouts | No dirty inputs; exact helper reads for admission; owner-attested stability | User explicitly confirmed both views are owner-prepared and will remain unchanged | TM-20260911-001-E0001, TM-20260911-001-E0002 | Answered before allocation; mechanical immutability not inferred |
| OPEN-002 | Non-blocking | Can an exact, blind-safe Project Manager handoff/queue be supplied through the permitted evidence boundary? | Full coordination and source-deduplication provenance is unavailable | Do not infer current approval, routing or queue absence from the parent redirect or short recorded PM ref | Unknown; no supplied copy | TM-20260911-001-E0004 | Open; limits new-source classification, not frozen target architecture |
| OPEN-003 | Non-blocking for source analysis; blocks stronger architectural claims | What do primary specifications require for G-stage U, HTVAL/HTINST, VSSTATUS UXL/WARL, VT controls, fences and SBI shutdown? | Distinguishes exact fixed-profile assumptions from architecture-wide guarantees | Source checks and documented QEMU assumptions are not normative proof or hardware validation | Pending bounded public-primary-source research | TM-20260911-001-E0011 | Open |
| OPEN-004 | Non-blocking for source analysis | What do primary GNU/compiler, Podman and npm documents establish about override/volatile behavior, isolation options, mutable closure and install scripts? | Defines the actual reach of credited host/tool controls | No malicious-tool sandbox, universal memory barrier, immutable package closure or container attestation is assumed | Pending bounded public-primary-source research | TM-20260911-001-E0011 | Open |
| OPEN-005 | Non-blocking for this source-led risk model; blocks execution-backed claims | Which owner-produced image, disassembly, log, tool/firmware inventory and evaluator bundle is bound to this exact target commit? | Required to claim current checks actually passed or isolation was observed | Static controls and test definitions only; no target execution or inherited run result | Unknown; no approved exact-target run bundle admitted | TM-20260911-001-E0005, TM-20260911-001-E0011 | Open |
| OPEN-006 | Non-blocking | What exact host UID, kernel, OCI runtime, installed dependency closure and patches were used for an applicable evaluation? | Required for deployment-specific isolation or CVE conclusions | Dependency compromise/failure is conditional; no particular installed vulnerability asserted | Unknown; no operator/environment inventory supplied | TM-20260911-001-E0011 | Open |
| OPEN-007 | Non-blocking | What retention, disposal, unhandled-interruption and shutdown erasure policy applies to memory, logs, source copies and caches? | Could change confidentiality, availability and recovery impact | No secure erasure, crash durability or bounded runtime progress guarantee assumed | Unknown; owner requirements and exact-platform evidence needed | TM-20260911-001-E0001 | Open |
| OPEN-008 | Non-blocking | Is the inventoried AWB inquiry complete, applicable to this target, and independent of the excluded earlier TM analyses? | Only completed eligible packages may contribute evidence | No AWB conclusion is imported while eligibility is unknown | Unknown; package metadata/history inventory only, report withheld | TM-20260911-001-E0010 | Open |
| OPEN-009 | Blocking for planned workflow completion | Authorize the current Astra orchestrator's mounted web tools for OPEN-003/004, restore an authorized specialist retrieval path, or explicitly choose an incomplete source-only continuation? | Research specialist lacked actual search/web tools; the confirmed run does not permit a silent capability fallback | Preserve original scope, private distribution, blind boundary and stopped public phase | ask_user reported the user unavailable; no selection or authorization received, including no consent inferred from the form default | TM-20260911-001-E0030 | Open; awaiting explicit workflow decision |
| OPEN-010 | Non-blocking for conditional source-led flow analysis | Which readable input classes may reach which accepted output carriers and recipients, and which content/disclosure checks govern that transfer? | Integrity and namespace acceptance do not establish authorized disclosure | THREAT-019 requires sensitive readable input, accepted carrier freedom and an unauthorized recipient; none presumed established | Unknown; owner flow/entitlement matrix and benign canary evidence needed | TM-20260911-001-E0023, TM-20260911-001-E0024, TM-20260911-001-E0025, TM-20260911-001-E0045 | Open; no actual leak or unrestricted carrier inferred |

Established: answers append to the question history. No scope confirmation
is a risk acceptance, publication decision, or responsible-human promotion.

## Resolution history

### OPEN-009: Resolved for the original specialist path

Established: on 2026-09-11 the user explicitly directed the stated resumption
plan. A fresh `threat-research` instance explicitly dispatched as
`gpt-6-astra` successfully performed local read/search, direct URL retrieval
and general web search without write/execute/delegation exposure. The
orchestrator did not substitute a broader built-in agent or a different model.
OPEN-009 is now resolved; the original table row preserves the earlier
unanswered state. OPEN-003/004 still require substantive primary-source
research. TM-20260911-001-E0031, TM-20260911-001-E0032.

### OPEN-003: Resolved at public-semantic depth

Established: the versioned RISC-V H/Supervisor and SBI sources are admitted as
TM-20260911-001-E0033 through TM-20260911-001-E0036. The model's public-source
applicability table records their bounded implications. This resolves the
normative reference question, not actual emulator/firmware execution,
conformance, portability, erasure or a completed binary proof. Those stronger
claims remain constrained by OPEN-005/006 and the recorded assumptions.

### OPEN-004: Resolved at public-semantic depth

Established: GNU Make, GCC, Clang/LLVM, Podman and npm primary documentation
is admitted as TM-20260911-001-E0037 through TM-20260911-001-E0044.
Version-selected documents are distinguished from living pages and unknown
installed versions. No current vulnerability, patch applicability or
independently authenticated dependency closure is inferred.

### Current question disposition

Established: OPEN-001, OPEN-003, OPEN-004 and OPEN-009 are resolved within
their stated question boundaries. OPEN-002, OPEN-005, OPEN-006, OPEN-007 and
OPEN-008 remain non-blocking for this explicitly source-led model.
They still block stronger assertions named in their original rows. The
independent review may identify a new blocking modeling gap; none is hidden
by this disposition.

### Independent-review follow-up

Established: the reviewer required no blocking user questions. OPEN-010 is a
new non-blocking question whose three conditions are explicit in THREAT-019
and ASSUMPTION-011. It joins OPEN-002/005/006/007/008 as a limit on stronger
claims; completing a conditional model does not answer recipient
authorization or prove an actual disclosure.
