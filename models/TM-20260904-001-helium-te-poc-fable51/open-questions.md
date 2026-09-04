# Open questions

Package ID: `TM-20260904-001`
Title: Helium TE PoC Independent Threat Model (Fable 5.1 replay)
Created: 2026-09-04
Status: `Complete`
Distribution: `private`

| Open ID | Blocking | Question | Why it matters | Assumption in use | Answer | Evidence IDs | Status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| OPEN-001 | Non-blocking | Does all-address, all-VMID `HFENCE.GVMA` invalidate every cached G-stage translation on real hardware as it does in QEMU, given both roots use VMID 0? | THREAT-005 residual depends on it. | ASSUMPTION-004: the fence is complete. | See answer record below: specification-level answer from secondary sources; hardware `NOT RUN`. | TM-20260904-001-E0066, E0056, E0064 | Partially answered |
| OPEN-002 | Non-blocking | Which optional or timing CSRs (`htimedelta`, FP/vector state) are outside the reader's reset baseline, and is that acceptable for the fixed profile? | THREAT-004 residual; MITIGATION-010. | `hcounteren = 0` makes `time` unobservable; FP/vector not enabled. | Not answered; documented as excluded by maintainers. | TM-20260904-001-E0021, E0032 | Open |
| OPEN-003 | Non-blocking | What is the threat environment of the host that produces retained evidence bundles (single operator workstation, CI, shared)? | Sets the likelihood of THREAT-013 and THREAT-014. | Likelihood 3 assumed for a non-hardened workstation. | Not recorded in evidence. | TM-20260904-001-E0017, E0047 | Open |
| OPEN-004 | Non-blocking | What is the full transitive npm dependency closure and its licence set? | THREAT-014 exposure of documentation tooling. | Lockfile integrity hashes pin the closure. | Not derived (would require execution). | TM-20260904-001-E0038 | Open |
| OPEN-005 | Non-blocking | Has the responsible human completed H6 source review of exact commit `1ab289c…`? | THREAT-015, THREAT-016; MITIGATION-006. | No: `docs/review-remediation.md` records H6/H7 incomplete. | Answered from evidence: incomplete at R1. | TM-20260904-001-E0052 | Answered |
| OPEN-006 | Non-blocking | Does the ratified specification permit `htval = 0` on a guest-page fault, making the recovery check non-portable? | THREAT-017. | Yes, per maintainers' documentation limit; QEMU populates it. | See answer record below: permitted per secondary sources. | TM-20260904-001-E0027, E0065 | Answered |

## Answer records (append-only)

| Date | Open ID | Answer | Evidence IDs | Resulting status |
| --- | --- | --- | --- | --- |
| 2026-09-04 | OPEN-001 | Specification level: secondary public summaries state `HFENCE.GVMA x0,x0` covers all guest-physical addresses and all VMIDs, so the source's fence form is the complete one. Hardware behaviour remains unknown (`NOT RUN`). | TM-20260904-001-E0064 | Partially answered (spec); open (hardware) |
| 2026-09-04 | OPEN-006 | Yes: secondary public summaries of Privileged v1.12 state `htval` may be written as zero when the GPA is not known. THREAT-017 is a genuine portability limit. | TM-20260904-001-E0065 | Answered (secondary source; primary text blocked, BLOCKED-001) |
