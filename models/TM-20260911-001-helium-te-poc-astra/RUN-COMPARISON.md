# Post-freeze comparison of three Helium threat-model runs

Package ID: `TM-20260911-001`
Title: Helium TE PoC Independent Threat Model (GPT-6 Astra)
Created: 2026-09-11
Status: `Complete`
Distribution: `private`
Document role: Non-normative, post-blind-freeze comparison

## Position and non-interference

Inferred: the runs substantially agree on the fixed architecture and the
importance of trusted implementation, evidence producers and human gates.
Their main differences are risk calibration, the boundary of conditional
control credit, granularity of host/lifecycle coverage, and evidence-access
conditions. The Astra run adds explicit treatment of native preflight,
permitted-output disclosure, parser limits and a caller-contract distinction,
while obtaining primary reference text unavailable to the earlier runs.
These differences do not establish a generally superior underlying model.

Established: this document was begun only after the new model and independent
review were completed, hash-frozen in BLIND-FREEZE.md, and passed package
completion validation, index regeneration and all 159 agent-contract checks.
No earlier-model observation was added to the blind evidence ledger or used
to modify its model, review, ratings, iterations or diagrams. Earlier
packages and the September 6 comparison were read-only; their instructions
and improvement proposals were treated as data, not executed.

## Comparison basis

Established: aliases are source references, not new entity/evidence IDs.
Every THREAT/CONTROL/FINDING identifier in a comparison column belongs to
that column's package; equal suffixes do not identify equal scenarios.

| Alias | Repository-relative package |
| --- | --- |
| A | `models/TM-20260901-001-helium-te-poc/` |
| B | `models/TM-20260904-001-helium-te-poc-fable51/` |
| C | `models/TM-20260911-001-helium-te-poc-astra/` |

Established: all three recorded scopes use clean Helium
`1ab289c066b69acdd8b55c9f77055b0145be1316` and historical Beryllium
`65f6d895a2007e8e093582cc48726375fd23b563`, create-from-evidence, Deep
runtime-plus-host/lifecycle scope, no authoritative source model and private
distribution. A/B record `for-review`; C uses the owner-prepared detached
view. This compares recorded package projections, not different target code.
Sources: A/scope.md, B/scope.md, C/scope.md.

| Field | A: initial run | B: Fable replay | C: Astra run |
| --- | --- | --- | --- |
| Created | 2026-09-01 | 2026-09-04 | 2026-09-11 |
| Latest model / review | 001 / 001 | 002 / 001 | 002 / 002 |
| Orchestrator attribution | Earlier comparison reports `gpt-5.6-sol-fast` | Earlier comparison reports `claude-fable-5.1` | Current runtime declares `gpt-6-astra` |
| Specialist attribution | Earlier comparison reports `gpt-5.6-sol` | Earlier comparison reports `gpt-5.6-sol` | Explicitly requested and harness-reported `gpt-6-astra` for analysis/review |
| Threats / evidence definitions | 14 / 46 | 18 / 67 | 19 / 46 |
| Objectives / boundaries / flows | 8 / 9 / 16 | 7 / 5 / 10 | 7 / 9 / 14 |
| Public reference access | Reports no public query could run | Reports secondary summaries, primary text unavailable | Twelve primary observations admitted after tool restoration |
| Review record | Five findings; subsequent independent checks reported | Thirteen findings; single reviewer pass and orchestrator dispositions reported | Three findings; same-reviewer bounded closure separately retained |

Established: A/B model attribution above is from
`THREAT-MODEL-RUN-COMPARISON-20260906.md`, which says it inspected local usage
records. That attribution was not independently reconstructed here; no
standalone root-level RUN-MANIFEST.md was found in either older package.
C's declarations/harness metadata are also not independent provider
attestation. The earlier comparison reports Sol specialists in both A and B,
so these are not three isolated, pure-model experimental stacks.

Unknown: identical effective prompts, budgets, reasoning settings, tool
environments, admission choices, review effort and exact historical package
bytes at generation time are not established. The hashes below bind the
older documents as read now, not a reconstructed earlier Git commit.
Counts describe artifacts and granularity, not vulnerability totals or
quality scores.

## Risk calibration

Established: direct counts of each current catalogue's
`Residual risk` fields give:

| Band | A | B | C |
| --- | ---: | ---: | ---: |
| Critical | 1 | 0 | 0 |
| High | 10 | 3 | 6 |
| Moderate | 3 | 5 | 12 |
| Low | 0 | 10 | 1 |
| Total | 14 | 18 | 19 |

Established: representative approximate matches, verified from the actual
threat records rather than executive rankings, are:

| Mechanism | A residual | B residual | C residual |
| --- | --- | --- | --- |
| Cross-private/wrong mapping | THREAT-002: 2 x 5 = 10 High | THREAT-001: 1 x 4 = 4 Low | THREAT-002: 2 x 4 = 8 Moderate |
| Stale translation at switch | THREAT-003: 2 x 5 = 10 High | THREAT-005: 1 x 4 = 4 Low | THREAT-004: 2 x 4 = 8 Moderate; combined with state residue |
| Forged/misplaced events | THREAT-005: 2 x 5 = 10 High | THREAT-003: 1 x 4 = 4 Low | THREAT-003: 2 x 4 = 8 Moderate |
| Register/CSR residue | THREAT-004: 2 x 3 = 6 Moderate | THREAT-004: 1 x 2 = 2 Low | THREAT-004: 2 x 4 = 8 Moderate; broader combined state/translation scenario |
| Self-consistent false evidence | THREAT-009: 3 x 5 = 15 High | THREAT-013: 3 x 4 = 12 High | THREAT-013: 3 x 4 = 12 High |
| Required platform/tool trust | THREAT-013: 4 x 5 = 20 Critical | THREAT-014: 2 x 5 = 10 High for supply chain; HS defect separately THREAT-008, 10 High | THREAT-007 and THREAT-011: each 3 x 4 = 12 High for separately described dependency/closure branches |
| Availability/non-progress | THREAT-007: 5 x 3 = 15 High, out of scope | THREAT-007: 5 x 1 = 5 Moderate, out of scope | THREAT-006: 4 x 2 = 8 Moderate, explicitly bounded experiment |
| Host/evaluator boundary | THREAT-010: 2 x 5 = 10 High, broad evaluator/export failure | Primarily represented in evidence/supply controls and threats | THREAT-009 native preflight 12 High; THREAT-010 ordinary correctly enforced paths 8 Moderate; failed enforcement THREAT-007 at 12 |

Inferred: A preserves larger consequence ratings and carries more unresolved
assurance uncertainty into core threat scores. B places more conditional
weight on the fixed-profile controls and separately models HS/platform
failure. C uses intermediate core scores but leaves several host, producer
and decision branches unreduced. Different impact anchors and scenario
boundaries mean C is not a numeric compromise or an average of A and B.
The availability row especially shows differing consequence interpretation,
not new knowledge that a guest can or cannot stop a run.

Established: C's review explicitly repaired overbroad aggregate credit.
Its THREAT-010 reduction does not cover malicious kernel/OCI failure, total
work budgets or permitted-output disclosure; those have separate unreduced
records. THREAT-014 keeps 9/25 for deliberate exceptions rather than claiming
safe defaults mitigate an already-selected unsafe exposure. Sources:
C/REVIEW-ITERATION-002 and C/THREAT-007/010/014/018/019.

## Control credit and evidence access

Established: none of the three admits an exact-target execution bundle as
the basis of these comparisons. A/review.md FINDING-001 removes current
credit from unexecuted verification-design CONTROL-009/010. B/review.md
FINDING-001 instead corrects observed-result wording and lowers confidence;
its THREAT-003/006 still list designed negative-image checks in their
residual rationales. C distinguishes runtime/source mechanisms, declared
assumptions and proposed verification, and its independent review checks
which branch a control can mediate. C does not claim a script passed merely
because its source exists.

Inferred: this is a methodological distinction, not just prose style.
Agreement that source code contains a check does not establish executed
effectiveness. A useful future calibration would align exact branch
preconditions, impact interpretation and credit type before comparing scores.
This document does not adopt a new calibration or re-rate any baseline.

Established: A reports that three public tracks issued no queries because
approved tools were unavailable. B records that its researcher lacked web
tools and that direct primary retrieval failed; its review explicitly limits
the resulting secondary summaries. C initially stopped on the same class of
tool-exposure problem, then resumed after separately authorized maintenance
and an actual Astra capability gate. C subsequently admitted versioned
RISC-V/SBI, GCC/LLVM/Podman and qualified living GNU/Clang/npm references.
These improve semantic reference grounding, not hardware or installed-code
assurance. Sources: A/HANDOFF.md; B/scope.md ACTIVITY-006 and
B/review.md FINDING-011; C/E0030-E0044 and RUN-MANIFEST.md.

## Coverage and review differences

Inferred: this table compares emphasis and granularity in the located
records, not exhaustive absence, novelty, or measured model quality.

| Area | Comparative observation |
| --- | --- |
| Native preflight | C/THREAT-009 separately identifies repository-owned native execution before retained-container restrictions; A has broader build/evaluator threats, while B emphasizes bundle/supply trust. |
| Permitted-output disclosure | C/THREAT-019 and ATTACK-003 explicitly require readable sensitive input AND an accepted carrier AND an unauthorized recipient. A/THREAT-010/012 cover adjacent evaluator/distribution concerns; B's per-surface table calls evidence-bundle information disclosure inapplicable because the bundle is intended output. Intended output alone does not answer recipient entitlement. This is an analytical difference, not proof of a leak or a novelty claim. |
| Nested traps | A/THREAT-006 is a dedicated High uncertainty; B/THREAT-009 treats unsupported origins/nesting within its fixed-path analysis; C/THREAT-005 remains conditional Moderate with Low confidence and no demonstrated trigger. |
| Mapping/caller assumptions | B/THREAT-010 proposes focused mapper/readback divergence verification. C/THREAT-017 separately preserves the failed-init postcondition mismatch while recognizing the fixed caller's terminal failure. Neither proposal is a target change performed here. |
| Retention and budgets | A explicitly retains shutdown-zeroization/lifecycle questions. C/THREAT-018 and OPEN-007 keep disposal, crash recovery and total workload bounds unresolved; C separates these from ordinary container-confinement credit. |
| Review traceability | A reports successive independent reconciliation checks despite one published review iteration. B reports one reviewer pass with orchestrator dispositions. C preserves both the first critique and independent closure as complete separate review iterations, plus normalized model snapshots and retained DOT hashes. |

Established: the older B executive summary still lists supply-chain
THREAT-014 as Moderate, while its detailed record, residual table and
handoff say High (2 x 5); B/review.md FINDING-007 records the correction.
This pre-existing inconsistency was also noted in the September 6 comparison.
It is recorded here without repairing B. Mechanical completion metadata
alone does not establish agreement of every narrative summary.

Established: B/scope.md records a mid-collection checkout switch, discarded
contaminated observations and guarded re-runs. It also self-reports
execution-allowlist deviations and a restricted-path-exclusion lapse with no
restricted content returned. These are recorded workflow reports, not
independently reconstructed execution logs. C used owner-prepared stable
views, exact-object admission checks and repeated state/hash checkpoints;
these are not a filesystem-enforced immutable-source adapter. The operating
conditions differ materially and cannot be attributed solely to model
reasoning. Sources: B/scope.md ACTIVITY-004/007; C/scope.md and RUN-MANIFEST.md.

## Source coverage and exact identities

Established: comparison reads covered both complete scope records, threat
catalogue headings and all band fields, selected corresponding threat
records, reviews, handoffs and evidence-definition counts. The September 6
comparison's attribution, risk/credit/workflow sections and selected proposal
context were read after C's freeze; proposals were not adopted or executed.
No raw historical session logs, target code, earlier package validation or
new public research was used for this comparison.

The following hashes were returned by the maintained helper at
2026-09-11T22:55:30Z. They bind the documents actually compared; a hash does
not imply every paragraph was reviewed or that historical assertions are
authenticated.

| Document | SHA-256 |
| --- | --- |
| A/scope.md | `0cdab8aea4f166a95d79b4ba7ee7fa2566819529d2e39f6d851e9da95051438b` |
| A/threat-model.md | `c3d6cbc573ac28bfba0cd51295b50e9acd2dd96983cd06d521f9d5b45a2d6c32` |
| A/review.md | `63c9f8c5713132b7124c462d5831926dc564db314d04daa8d5635469352cd759` |
| A/HANDOFF.md | `4b3fbaf9e8ba9882a735ef4cdff8eb2f1f1f3beb6a7d9ebb3140933cd17f219d` |
| A/evidence-ledger.md | `4f859dc26c3fc4810bc972f9077db5c958f0cdbb6ccf561b8c17101ccbce47a1` |
| B/scope.md | `2294a3fdb1a44d1142e7ed231d9ff4388b421402f242d45d2f252b7d632c9031` |
| B/threat-model.md | `4bf9c994d8a4894f267ac0e6cf129e99286d5b8833824adbad9af6f6db8568f5` |
| B/review.md | `56818c8698ef3dcfaa1949181fca598c02135acea68a3482d6927138d648078a` |
| B/HANDOFF.md | `415a6536574314b7a458c1ca88708cd34289424fbb1dc40c3a8b6bec51fe2166` |
| B/evidence-ledger.md | `8ff225da9727859ce63f9538a473a0811e2f3aa51f4a01e4c8f826beb5e65e13` |
| THREAT-MODEL-RUN-COMPARISON-20260906.md | `71f4ccd1eee54b8b3886dc77fbf5fc678c4937856fa964b7acda1f984b5d8374` |
| C analytical baseline | Every hash in BLIND-FREEZE.md matched the post-comparison recheck at 2026-09-11T23:00:18Z |

Established: the same post-comparison check confirmed all eleven A/B/September
6 source-document hashes above unchanged. Both target/context views remained
at their exact clean heads, with zero changed entries. Maintained package
completion validation and index-current checking passed with this comparison
present. These are read-only preservation checks, not revalidation or repair
of the older packages.

## Bounded use

Proposed: use the three outputs as a challenge set for owner-led verification,
not a vote or a model leaderboard. Prioritize exact-target execution/
correspondence evidence, explicit per-branch credit and readable-input/
accepted-output/recipient controls. Additional work requires its own owner
and authorization; no implementation, old-package repair or workflow adapter
is commissioned by this comparison.

Established: all three packages remain private and preserve the
review-and-test PoC/non-formal/non-hardware boundary. Beryllium accepted
through R7, R8-H0 unaccepted candidate and K3 NOT RUN are not transferred into
Helium acceptance. No risk, model, source, publication, licensing, release or
human promotion decision is granted.
