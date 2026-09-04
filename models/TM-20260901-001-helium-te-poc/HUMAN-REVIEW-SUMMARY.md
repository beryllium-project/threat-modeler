# Human review summary and worksheet

Package ID: `TM-20260901-001`
Title: Helium TE PoC Initial Threat Model
Created: 2026-09-01
Status: `Complete`
Distribution: `private`

## Purpose and authority

Use this document to work through a responsible-human review of the initial
threat model for clean `helium-te-poc` commit
`1ab289c066b69acdd8b55c9f77055b0145be1316`.

This worksheet is non-normative. `threat-model.md`, `review.md`, the evidence
ledger, numbered iterations, and DOT sources remain the normative package.
Completing this worksheet does not itself:

- accept residual risk;
- complete Helium H6 source review or H7 release action;
- approve an exception;
- approve release or publication;
- promote this package from `private`;
- establish formal verification or hardware validation; or
- create a `HUMAN-PROMOTION-NNN` record.

Record those decisions only in their separately governed, responsible-human
processes.

## How to use this worksheet

For each row, enter one of:

- `Agree`;
- `Needs model change`;
- `Needs evidence`;
- `Defer - <reason>`;
- `Out of scope - <reason>`; or
- `Not reviewed`.

Add the evidence, reasoning, and exact next action. Do not use `Agree` as a
synonym for risk acceptance. If a material model or review change is needed,
create a new complete numbered iteration rather than rewriting a committed
iteration.

## Human review session record

All values in this table are for the responsible human to complete.

| Field | Human entry |
| --- | --- |
| Reviewer name | Not recorded |
| Reviewer role | Not recorded |
| Review start, UTC | Not recorded |
| Review end, UTC | Not recorded |
| Target revision independently confirmed | Not recorded |
| Model iteration reviewed | `MODEL-ITERATION-001` |
| Review iteration reviewed | `REVIEW-ITERATION-001` |
| Review scope or exclusions changed | Not recorded |
| Conflicts of interest or limitations | Not recorded |
| Working notes locator | Not recorded |

## Snapshot and model position

| Item | Current package position | Human assessment |
| --- | --- | --- |
| Mode | `create-from-evidence`, Deep | Not reviewed |
| Target | Clean `for-review` commit `1ab289c066b69acdd8b55c9f77055b0145be1316` | Not reviewed |
| Package state | Complete, `private` | Not reviewed |
| Intended distribution | Future `public-candidate` request only | Not reviewed |
| Evidence | 46 admitted records | Not reviewed |
| Model coverage | 8 objectives, 11 assets, 11 actors, 9 boundaries, 16 flows, 10 entries, 14 threats | Not reviewed |
| Independent model review | Five findings, all reconciled | Not reviewed |
| Public research | Three bounded tracks blocked before query because web capability was unavailable | Not reviewed |

The current model position is:

> Fixed source-level TE, G-stage, subject-transition, and fail-closed controls
> are coherent for the stated PoC, but they do not establish current
> execution, formal verification, hardware behavior, evidence authenticity,
> human approval, or accepted residual risk.

Human assessment of that position:

```text
Not recorded.
```

## Claim boundary checklist

Confirm each statement remains exact before reviewing technical risk:

- [ ] Helium is a review-and-test proof of concept.
- [ ] Helium is not formally verified.
- [ ] Helium is not hardware validated.
- [ ] No CBMC result applies to the frozen target revision.
- [ ] The two VS subjects are synthetic and sequential, not complete VMs.
- [ ] The fixed writer-to-reader shared-page flow is intentional.
- [ ] Availability, arbitrary-guest containment, broad noninterference, and
      side-channel resistance are not claimed.
- [ ] Beryllium acceptance through R7 does not transfer to Helium.
- [ ] Beryllium R8-H0 is a committed candidate and is not accepted.
- [ ] K3 hardware remains `NOT RUN`.
- [ ] Historical chats are non-authoritative design provenance.
- [ ] Historical AI reviews are challenge evidence against older revisions.
- [ ] The package remains private; intended `public-candidate` distribution is
      not promotion, publication, sign-off, or release.

Human notes:

```text
Not recorded.
```

## Recommended reading order

1. `scope.md` - confirm the exact target, boundary, exclusions, depth, and
   distribution intent.
2. `discovery.md` - confirm candidate classification and why no source model
   was selected.
3. `diagrams/system-context.dot`,
   `diagrams/trust-boundaries.dot`, and `diagrams/data-flows.dot` - confirm
   actor, authority, and flow direction.
4. `threat-model.md` through the threat catalogue - confirm architecture,
   objectives, assets, actors, TCB, boundaries, flows, and entries.
5. THREAT-013, THREAT-006, THREAT-002, THREAT-003, and THREAT-005 - review
   the highest-priority residual risks first.
6. `evidence-ledger.md` - spot-check direct target evidence and all
   assumption-bound claims.
7. `open-questions.md` and the mitigation table in `threat-model.md` - decide
   which evidence or design work is required.
8. `review.md` - confirm FINDING-001 through FINDING-005 were correctly
   reconciled.
9. `publication-checklist.md` - confirm why promotion remains blocked.

## Stop conditions

Pause this review and request a scope or iteration update if any of these is
true:

- [ ] The revision under review is not exactly
      `1ab289c066b69acdd8b55c9f77055b0145be1316`.
- [ ] Dirty or untracked target content is being relied on.
- [ ] A later successor's CBMC, test, review, or acceptance status is being
      attributed to this revision.
- [ ] A current control is credited only because test source exists, without
      an admitted exact-revision run.
- [ ] A historical prompt, AI review, PRV/AWB conclusion, or parent record is
      being treated as target implementation fact without corroboration.
- [ ] A private/internal source is being copied into a public derivative
      without clearance.
- [ ] A low or mitigated risk is being described as accepted.
- [ ] A proposed mitigation is being described as implemented.

Stop-condition notes:

```text
Not recorded.
```

## Priority 1: trusted dependency risk

### THREAT-013 - trusted firmware, emulator, toolchain, or hardware subverts the result

Current residual rating: `Critical` (`Likelihood 4 x Impact 5`), Medium
confidence. Evidence: TM-20260901-001-E0014 through
TM-20260901-001-E0022, TM-20260901-001-E0041,
TM-20260901-001-E0043, TM-20260901-001-E0044, and
TM-20260901-001-E0046.

Review questions:

- [ ] Is the dependency list complete for the fixed claim?
- [ ] Does likelihood 4 match the intended adversary and use of the PoC?
- [ ] Is impact 5 appropriate if any one dependency can falsify behavior and
      evidence?
- [ ] Are CONTROL-008, CONTROL-011, CONTROL-012, CONTROL-013, and
      CONTROL-017 the only controls that deserve current credit?
- [ ] Is MITIGATION-001 sufficient for exact-revision correspondence?
- [ ] Is MITIGATION-005 needed to add an independent acquisition or
      authentication axis?
- [ ] Is MITIGATION-004 required before making any portability or hardware
      claim?

| Human field | Entry |
| --- | --- |
| Assessment | Not reviewed |
| Revised likelihood, if any | Not recorded |
| Revised impact, if any | Not recorded |
| Required evidence | Not recorded |
| Required model change | Not recorded |
| Exact next action | Not recorded |

## Priority 2: runtime isolation and transition

| Threat | Current residual risk | Review focus | Primary evidence | Human assessment | Notes/action |
| --- | --- | --- | --- | --- | --- |
| THREAT-001 | High, 2 x 5 | Can trusted policy/TE state be altered coherently despite API checks? | E0005-E0008, E0014, E0037 | Not reviewed | Not recorded |
| THREAT-002 | High, 2 x 5 | Are cross-private absence and permission reconciliation complete for all six resources? | E0004-E0008, E0018, E0037 | Not reviewed | Not recorded |
| THREAT-003 | High, 2 x 5 | Is VMID-zero root/fence ordering sufficient, and is platform behavior adequately evidenced? | E0008, E0011, E0012, E0018, E0019, E0046 | Not reviewed | Not recorded |
| THREAT-004 | Moderate, 2 x 3 | Does the reset contract cover every state item required by the fixed claim? | E0009-E0011, E0018, E0023, E0024 | Not reviewed | Not recorded |
| THREAT-005 | High, 2 x 5 | Is every accepted cause, PC, address, phase, policy, PTE, and sentinel condition bound? | E0010-E0012, E0018, E0019 | Not reviewed | Not recorded |
| THREAT-006 | High, 2 x 5 | Can a nested HS trap occur, and what happens to trusted stack/control state? | E0014, E0023-E0025 | Not reviewed | Not recorded |

### Nested-trap decision worksheet

THREAT-006 is low confidence but high impact. Do not resolve it by assumption
without recording the basis.

- [ ] Review the direct trap prologue and every reachable HS fault source.
- [ ] Confirm whether disabled interrupts are sufficient to prevent all
      nesting.
- [ ] Check whether synchronous faults can occur before trusted stack state is
      secure.
- [ ] Decide whether evidence of unreachability is adequate.
- [ ] If not, commission MITIGATION-002.
- [ ] Record whether this changes likelihood, impact, confidence, or status.

Human conclusion:

```text
Not recorded.
```

## Priority 3: build, evidence, evaluator, and review chain

| Threat | Current residual risk | Review focus | Primary evidence | Human assessment | Notes/action |
| --- | --- | --- | --- | --- | --- |
| THREAT-008 | High, 2 x 5 | Can an alternate rule, trusted tool, or host race produce an unreviewed image? | E0014, E0015, E0018, E0020 | Not reviewed | Not recorded |
| THREAT-009 | High, 3 x 5 | Can one producer create self-consistent but false source, artifacts, traces, and review metadata? | E0017, E0019-E0023, E0040, E0045 | Not reviewed | Not recorded |
| THREAT-010 | High, 2 x 5 | Does the evaluator adequately isolate source, host, provenance, and export? | E0016, E0020, E0024 | Not reviewed | Not recorded |
| THREAT-011 | Moderate, 2 x 4 | Can historical or successor evidence be mistaken for current assurance? | E0002, E0017, E0022-E0036, E0041, E0044 | Not reviewed | Not recorded |
| THREAT-012 | Moderate, 2 x 4 | Could private evidence be disclosed or promoted without authority? | E0017, E0027-E0032, E0035, E0036, E0042, E0045 | Not reviewed | Not recorded |

### Verification-source credit check

FINDING-001 required this distinction:

- [ ] CONTROL-009 and CONTROL-010 are implemented verification designs.
- [ ] Neither receives residual-risk credit without an admitted exact frozen
      revision run.
- [ ] Historical execution claims in E0026 are not treated as current runs.
- [ ] An exact clean bundle, if later supplied, is reviewed before ratings are
      changed.

Human conclusion:

```text
Not recorded.
```

## Priority 4: explicit non-goals and broader claims

| Threat | Current residual risk | Review focus | Human assessment | Notes/action |
| --- | --- | --- | --- | --- |
| THREAT-007 | High, 5 x 3; Out of scope | Confirm that availability is intentionally excluded and not needed for the review decision. | Not reviewed | Not recorded |
| THREAT-014 | High, 3 x 4 | Confirm that shared, optional CSR, microarchitectural, timing, and teardown channels remain conspicuous limits. | Not reviewed | Not recorded |

If either property is required for the intended use, do not simply change its
status. Expand scope, gather evidence, and create a successor model iteration.

## Control review

| Control group | IDs | Human checks | Assessment | Required follow-up |
| --- | --- | --- | --- | --- |
| Policy and mapping | CONTROL-001 through CONTROL-004 | Complete mediation, default deny, one-rule semantics, root/backing validation, correct PTE bits | Not reviewed | Not recorded |
| Entry, transition, and traps | CONTROL-005 through CONTROL-007 | GPR/CSR reset, VVMA/GVMA ordering, exact state machine, nested-trap limit | Not reviewed | Not recorded |
| Build constraints | CONTROL-008, CONTROL-011 | Canonical graph, tools, paths, outputs, alternate-rule boundary | Not reviewed | Not recorded |
| Verification design | CONTROL-009, CONTROL-010 | Coverage is useful but receives no current execution credit | Not reviewed | Not recorded |
| Evidence and evaluator | CONTROL-012, CONTROL-013 | Correspondence, acquisition, producer trust, host/container trust, rollback | Not reviewed | Not recorded |
| Review and documentation | CONTROL-014, CONTROL-015 | Provenance, generated output, serving boundary, downstream claim risks | Not reviewed | Not recorded |
| Human and claim gates | CONTROL-016, CONTROL-017 | Blocked state, human authority, claim limits, no inferred approval | Not reviewed | Not recorded |

## Evidence spot-check plan

| Evidence | What to verify | Checked | Result/notes |
| --- | --- | --- | --- |
| E0001 | Exact clean target and scope binding | [ ] | Not recorded |
| E0005-E0008 | TE mechanism, policy, mapping derivation, and G-stage encoding | [ ] | Not recorded |
| E0009-E0012 | Initialization, writer, transition, reader, trap, and shutdown behavior | [ ] | Not recorded |
| E0014 | TCB assumptions and explicit non-goals | [ ] | Not recorded |
| E0015-E0021 | Build, evaluator, evidence, review, and documentation controls | [ ] | Not recorded |
| E0022 | Absence of formal, CBMC, binary, and hardware assurance at this revision | [ ] | Not recorded |
| E0023-E0024 | Historical review conflicts and current remediation disposition | [ ] | Not recorded |
| E0025 | Nested-trap uncertainty | [ ] | Not recorded |
| E0027-E0032 | Historical chats and curated future-only architecture | [ ] | Not recorded |
| E0036-E0040 | Completed PRV/AWB provenance, lineage, prior art, and readback analysis | [ ] | Not recorded |
| E0041, E0044 | Successor-only formal work and no assurance inheritance | [ ] | Not recorded |
| E0045 | Private evidence and promotion blockers | [ ] | Not recorded |
| E0046 | Public research did not run; no unsupported negative claim | [ ] | Not recorded |

## Open-question triage

| Open ID | Topic | Suggested review action | Human priority | Owner | Due or trigger | Disposition |
| --- | --- | --- | --- | --- | --- | --- |
| OPEN-001 | Ratified RISC-V hypervisor semantics | Complete MITIGATION-008 before portability conclusions | Not recorded | Not recorded | Not recorded | Not reviewed |
| OPEN-002 | VBS/VTL/enclave comparison boundary | Complete MITIGATION-008 before comparative claims | Not recorded | Not recorded | Not recorded | Not reviewed |
| OPEN-003 | TE/mapping primary prior art | Complete MITIGATION-008 before stronger lineage claims | Not recorded | Not recorded | Not recorded | Not reviewed |
| OPEN-004 | Nested HS trap reachability | Prioritize with MITIGATION-002 | Not recorded | Not recorded | Not recorded | Not reviewed |
| OPEN-005 | Exact clean execution/evidence bundle | Prioritize with MITIGATION-001 | Not recorded | Not recorded | Not recorded | Not reviewed |
| OPEN-006 | Shutdown/reset zeroization | Decide whether teardown confidentiality is required | Not recorded | Not recorded | Not recorded | Not reviewed |
| OPEN-007 | Optional CSR and microarchitectural state | Decide whether broader confidentiality is required | Not recorded | Not recorded | Not recorded | Not reviewed |
| OPEN-008 | Transcript authentication | Required only for stronger historical claims | Not recorded | Not recorded | Not recorded | Not reviewed |
| OPEN-009 | Redistribution clearance | Required before any promotion work | Not recorded | Not recorded | Not recorded | Not reviewed |
| OPEN-010 | Direct standalone transfer | Required only for stronger transfer/authorship claims | Not recorded | Not recorded | Not recorded | Not reviewed |
| OPEN-011 | Independent evidence acquisition | Prioritize with MITIGATION-005 if evidence authenticity matters | Not recorded | Not recorded | Not recorded | Not reviewed |

## Mitigation prioritization

| Mitigation | Purpose | Current status | Human priority | Decision rationale | Exact next action |
| --- | --- | --- | --- | --- | --- |
| MITIGATION-001 | Exact clean target evidence bundle and independent tool selection | Open | Not recorded | Not recorded | Not recorded |
| MITIGATION-002 | Resolve or harden nested-HS-trap behavior | Open | Not recorded | Not recorded | Not recorded |
| MITIGATION-003 | Complete state-transition and shutdown-disposal contract | Open | Not recorded | Not recorded | Not recorded |
| MITIGATION-004 | Alternate emulator and eventual hardware validation | Open | Not recorded | Not recorded | Not recorded |
| MITIGATION-005 | Independent source/image/evidence/reviewer authentication axis | Open | Not recorded | Not recorded | Not recorded |
| MITIGATION-006 | Separate human H6, H7, and promotion records | Open; agent cannot complete | Not recorded | Not recorded | Not recorded |
| MITIGATION-007 | Redistribution clearance or public derivative | Blocked on clearance | Not recorded | Not recorded | Not recorded |
| MITIGATION-008 | Complete blocked public-primary-source research | Blocked on research capability | Not recorded | Not recorded | Not recorded |
| MITIGATION-009 | Exact-source machine checking with explicit boundaries | Open | Not recorded | Not recorded | Not recorded |

## Independent-review reconciliation

Confirm the current model resolves each review finding:

| Finding | Required result | Human assessment | Notes |
| --- | --- | --- | --- |
| FINDING-001 | CONTROL-009/010 receive no current execution or residual-risk credit | Not reviewed | Not recorded |
| FINDING-002 | THREAT-002/003/005 retain impact 5 because bypass consequences are not contained | Not reviewed | Not recorded |
| FINDING-003 | Threat records and coverage matrix are bidirectionally consistent | Not reviewed | Not recorded |
| FINDING-004 | DOT flow directions and mediation match Markdown | Not reviewed | Not recorded |
| FINDING-005 | Handoff, discovery, questions, and iterations point to current evidence | Not reviewed | Not recorded |

## Human review outcome

This section records only the reviewer's assessment of the model. It is not a
risk-acceptance, H6, H7, promotion, publication, or release record.

| Outcome field | Human entry |
| --- | --- |
| Review completed | Not recorded |
| Model is fit for its stated private purpose | Not recorded |
| Material model changes required | Not recorded |
| Material review changes required | Not recorded |
| Additional evidence required | Not recorded |
| Blocking unknowns | Not recorded |
| Recommended next action | Not recorded |
| Separate risk decision required | Not recorded |
| Separate H6/H7 process required | Not recorded |
| Separate distribution/promotion process required | Not recorded |

### Human rationale

```text
Not recorded.
```

### Required changes

```text
Not recorded.
```

### Evidence or assurance work to commission

```text
Not recorded.
```

### Exact next action

```text
Not recorded.
```

## Change handling

If review changes the model:

1. preserve `MODEL-ITERATION-001` and `REVIEW-ITERATION-001` unchanged once
   committed;
2. append new evidence, search, inaccessible-resource, and activity records
   rather than deleting history;
3. create the next complete model or review iteration for material changes;
4. update the current `threat-model.md` or `review.md` projection;
5. regenerate DOT-derived SVG only through the maintained renderer; and
6. run maintained baseline and completion validation before relying on the
   successor package state.
