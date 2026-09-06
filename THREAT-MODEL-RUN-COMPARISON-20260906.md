# Helium threat-model run comparison and agent improvement proposals

Date: 2026-09-06
Handling: private
Document type: Non-normative comparison and improvement proposal
Agent changes: Proposed only; not implemented

## Overall assessment

**Inferred:** The largest difference between the two runs is risk calibration,
not a fundamentally different understanding of the code. The Sol run is more
conservative about unresolved failures and assurance gaps. Fable gives more
credit to controls within the fixed profile, while separating possible
implementation failures into other threats. Sol has broader operational and
lifecycle coverage; Fable identifies more discrete implementation follow-up
items. Neither observation establishes that one underlying model is generally
better at threat modeling.

**Established:** Both packages describe Helium as a review-and-test proof of
concept, not formally verified and not hardware validated. Both remain
`private`. This comparison does not re-rate their threats, supersede either
package, authorize a target change, or grant approval or risk acceptance.

## Comparison basis and source references

**Established:** The compared projections and recorded generation models are:

| Field | Run A: Sol | Run B: Fable |
| --- | --- | --- |
| Package | `TM-20260901-001` | `TM-20260904-001` |
| Created | 2026-09-01 | 2026-09-04 |
| Latest model iteration | `MODEL-ITERATION-001` | `MODEL-ITERATION-002` |
| Latest review iteration | `REVIEW-ITERATION-001` | `REVIEW-ITERATION-001` |
| Generation orchestrator in local usage records | `gpt-5.6-sol-fast` | `claude-fable-5.1` |
| Specialist model in local usage records | `gpt-5.6-sol` | `gpt-5.6-sol` |
| Mode and depth | `create-from-evidence`, Deep | `create-from-evidence`, Deep |

**Established:** References beginning `A/` and `B/` below are package-relative
aliases, not new evidence identifiers:

| Alias | Repository-relative package directory |
| --- | --- |
| A | `models/TM-20260901-001-helium-te-poc/` |
| B | `models/TM-20260904-001-helium-te-poc-fable51/` |

**Established:** Both `scope.md` files freeze clean `helium-te-poc` commit
`1ab289c066b69acdd8b55c9f77055b0145be1316` and historical Beryllium context at
`65f6d895a2007e8e093582cc48726375fd23b563`. Their system, lifecycle, included
surfaces, and research permissions are substantially the same. B records
reading only A's scope to recover intake inputs and excluding A's analysis
from evidence. This comparison concerns those frozen outputs, not the current
Helium checkout.

**Established:** The comparison uses each package's `scope.md`,
`threat-model.md`, `review.md`, `evidence-ledger.md`, `discovery.md`,
`search-log.md`, `open-questions.md`, and `HANDOFF.md`. Runtime attribution
comes from local CLI session usage metadata read on 2026-09-06: session
`befa5550-cf99-4462-b2c9-f8fc99fb9a27`, generation turn 2, for A; and session
`bf4f541b-3e54-4efa-b96e-efc2653df3a5`, generation turns 0 and 2, for B.
These are observed runtime model IDs, not inferred from package titles or
agent frontmatter. Raw session logs are not copied into this document.

**Unknown:** Byte-identical effective prompts, equal reasoning budgets, and
identical tool environments were not established. Matching intake and target
commits do not make this a controlled comparison of two independent model
stacks: both runs used Sol specialists, and their research and checkout
conditions differed.

## Significant differences

### Residual-risk calibration

**Established:** Counting the individual threat records gives:

| Residual band | A: 14 threats | B: 18 threats |
| --- | ---: | ---: |
| Critical | 1 | 0 |
| High | 10 | 3 |
| Moderate | 3 | 5 |
| Low | 0 | 10 |

**Established:** Representative corresponding scenarios are below. Scores
are likelihood x impact. The matches are approximate because the runs group
causes, consequences, and assumptions differently; equal numeric IDs are not
necessarily the same threat.

| Scenario | A: Sol | B: Fable |
| --- | --- | --- |
| Cross-private mapping/access | THREAT-002: High, 2 x 5 | THREAT-001: Low, 1 x 4 |
| Stale translation after root switch | THREAT-003: High, 2 x 5 | THREAT-005: Low, 1 x 4 |
| Forged protocol events | THREAT-005: High, 2 x 5 | THREAT-003: Low, 1 x 4 |
| Register/CSR residue | THREAT-004: Moderate, 2 x 3 | THREAT-004: Low, 1 x 2 |
| Fabricated evidence | THREAT-009: High, 3 x 5 | THREAT-013: High, 3 x 4 |
| Trusted-platform/build compromise | THREAT-013: Critical, 4 x 5; broader dependency-failure scenario | THREAT-014: High, 2 x 5; supply-chain scenario |

**Established:** B still rates guest-triggered HS C defects High
(THREAT-008) and policy/PTE divergence Moderate (THREAT-010). A keeps core
mapping, fence, and trap-confusion consequences at impact 5 after review,
because preventive checks do not contain the consequence of a successful
bypass. Both counts include explicit non-goals: for example, availability
is High, 5 x 3, in A/THREAT-007 and Moderate, 5 x 1, in B/THREAT-007.
Sources: both threat catalogues; A/review.md FINDING-002.

**Inferred:** B's Low guest-mechanism ratings are conditional on correct HS
code and platform behavior, with some failure causes accounted for
separately. A carries more assurance uncertainty into individual ratings.
The totals are therefore not a vulnerability count or a quality score.
Equally, A's Critical dependency rating does not establish an actual or
likely compromise merely because dependency correctness is unproven.

### Credit for unexecuted checks

**Established:** Neither run admitted an exact-revision execution bundle.
Both reviews challenged claims based on unexecuted verification material,
but their resolutions differ.

| Aspect | A | B |
| --- | --- | --- |
| Review correction | Removes residual-risk credit from unexecuted test and runner sources | Changes wording and lowers confidence for affected threats |
| Current projection | CONTROL-009/010 explicitly receive no residual-risk reduction until an exact-revision run is admitted | Negative-image checks remain existing controls and appear in residual rationales, including THREAT-003/006 |
| Traceability | A/review.md FINDING-001; A/threat-model.md controls table | B/review.md FINDING-001; B/threat-model.md CONTROL-009 and THREAT-003/006 |

**Inferred:** This is a methodological difference, not just editorial style.
Both can reason about implemented runtime controls from source, but an
unexecuted test is not evidence that the tested behavior occurred. B's lower
ratings do not reflect newly demonstrated runtime behavior.

### Coverage and mitigation emphasis

**Established:** The following differences appear in the current projections:

| Surface | A's treatment | B's treatment |
| --- | --- | --- |
| Nested HS traps | Dedicated High uncertainty, THREAT-006; reachability question OPEN-004; MITIGATION-002 | Nested traps noted as unsupported in THREAT-009; no equivalent dedicated reachability question or mitigation |
| Evaluator/container and export compromise | Dedicated High THREAT-010 and separate host/export boundaries | Evaluator primarily appears as a control against evidence fabrication; no equivalent dedicated escape/export threat |
| Shutdown confidentiality | Explicit missing zeroization/disposal contract, OPEN-006 and MITIGATION-003 | No equivalent explicit shutdown-confidentiality question |
| Multi-hart boot | Single-hart environmental assumption | Dedicated THREAT-011 and a proposed early hart gate; explicitly outside the supported single-hart profile |
| Mapper/checker common failure | Broad mapping and policy-correspondence treatment | Separate THREAT-010 and MITIGATION-002 proposing a direct PTE-mutation negative test |
| Portability and preview exposure | Covered within broader availability, publication, and documentation concerns | Separate `htval` portability THREAT-017 and remote-preview THREAT-018 |

**Established:** A defines nine trust boundaries and sixteen flows; B defines
five boundaries and ten flows. A has 46 allocated evidence records, B has 67,
including superseding and engagement records. B also proposes more specific
actions such as an optional-CSR baseline, stack-depth analysis, and gate
authentication. These are proposals, not implemented controls. Sources:
both boundary, flow, control, and mitigation sections and evidence ledgers.

**Inferred:** B's larger threat and evidence counts do not imply broader
coverage. A more clearly preserves some lifecycle and host-side uncertainties;
B makes several narrower follow-up tasks easier to identify.

### Review reconciliation and a remaining inconsistency

**Established:** A records five findings, corrections, and subsequent
independent re-review. B records thirteen findings and one independent
reviewer pass. The numbers alone do not establish relative quality.
Sources: both `review.md` conclusions; B/FINDING-012.

**Established:** B's current executive summary still calls supply-chain
THREAT-014 Moderate, while the corrected threat record, residual-risk table,
and handoff call it High, 2 x 5. B/review.md FINDING-007 says the impact and
band were corrected. The disagreement remains visible in
B/threat-model.md's executive summary and THREAT-014 record. This document
records the discrepancy without repairing the original package.

### Research access and operational conditions

**Established:** A obtained no public-search results. B obtained AI-mediated
secondary summaries but did not read the primary specification text.
Its E0064/E0065 therefore do not establish a completed primary-source review.
Sources: both `search-log.md` files and B/evidence-ledger.md E0064/E0065.

**Established:** B records a mid-run checkout change, discarded contaminated
specialist observations, and repeated evidence collection. It also
self-reports execution-allowlist deviations and a sibling search that failed
to exclude the restricted subtree by path. The record says no restricted
content was read or copied and no target or sibling content was modified by
the execution deviations. Sources: B/scope.md ACTIVITY-004 and ACTIVITY-007;
B/evidence-ledger.md E0004. These reports are not independently reconstructed
execution logs.

**Inferred:** These are material differences in workflow reliability and
experimental conditions. They should not be hidden behind a common package
status or interpreted as differences in the frozen target implementation.

## Prioritized agent improvements

**Proposed:** Priorities below are an implementation order, not vulnerability
severities or approval decisions. None of these changes is implemented by
this document. Keep the existing private-first, read-only-target, append-only,
and responsible-human boundaries.

### P0: Make specialist evidence reads revision-addressed

**Established basis:** B's live-checkout incident demonstrates the limitation
of supplying an exact revision in a prompt while specialists read ordinary
worktree files. `scripts/readonly-inspect.sh` already supports committed
`show` and `ls-tree` operations; specialists declare only read/search tools.

**Proposed change:** Supply a narrowly scoped, maintained read/search
interface that returns committed blobs at the frozen SHA. Bind each result
to component, commit, relative path, and a content identity. For review-only
work, supply an immutable admitted-evidence set and model projection rather
than relying on fresh live-checkout reads. Do not give specialists general
shell access or copy private implementation source into tracked artifacts.
Keep explicitly approved dirty overlays separate and hashed; reject
unapproved paths before reading.

**Proposed completion criterion:** A synthetic checkout switch or dirty-file
change cannot change the evidence returned for a clean frozen revision.
Start/end HEAD checks may supplement this, but cannot replace it.

### P0: Enforce tool boundaries and preflight research capability

**Established basis:** The orchestrator declares a general execution tool,
with the helper allowlist stated in instructions. B records prohibited
fallback invocations despite those instructions. The research profile
declares web access, but both runs encountered unavailable research tools.
Sources: `.github/agents/threat-modeler.agent.md`,
`.github/agents/threat-research.agent.md`, B/scope.md ACTIVITY-007, and both
search logs.

**Proposed change:** Expose only approved helper operations through a
capability-limited adapter or equivalent maintainer-controlled enforcement.
Apply component/path exclusions before every read or search, not just to
returned results. Check actual specialist tool availability before
dispatching research. If unavailable, record the block and stop that phase;
never substitute a network client or interpreter. Keep primary-text gaps
open when only secondary summaries are available.

**Proposed completion criterion:** Synthetic fixtures deny unauthorized
executables and excluded-path reads before execution or access. A missing
web capability produces a blocked research record without a fallback call.
This requires runtime integration, not simply more prompt wording.

### P1: Specify control evidence and risk-credit rules

**Established basis:** Both FINDING-001 records identify the same class of
over-crediting, but their corrections lead to different residual ratings.
`templates/threat-model.md` has effectiveness/confidence columns without
structured execution-status or risk-credit fields.

**Proposed change:** Record each control's role (runtime prevention,
containment, detection, or verification design), evidence basis
(source-only, exact-revision execution, or independent reproduction),
required assumptions, and the likelihood/impact reduction actually claimed.
Unexecuted tests receive no execution-backed risk credit. Source-supported
runtime controls can still receive explicitly reasoned, conditional credit.
Require consequence-containment evidence for reductions in impact.

**Proposed change:** Calibrate likelihood against actor capabilities and the
stated operating environment, separately from confidence. Missing proof must
not automatically mean likely exploitation; a narrow design must not
automatically mean a demonstrated Low residual risk. Identify which risks
are conditional on trusted dependencies and which assess dependency failure.

**Proposed completion criterion:** A source-only test cannot silently lower
residual risk, every reduction cites its basis, and equal scenarios use the
same rating anchors. Update the skill, control/evidence templates, and
review-specialist contract together.

### P1: Strengthen semantic completion and summary consistency

**Established basis:** `scripts/validate-threat-model.sh` already checks risk
products/bands, required fields, identifier existence, metadata, and diagram
freshness. Its coverage check counts identifier occurrences rather than
validating reciprocal relationships. Its review-completeness check rejects
literal `Incomplete`, whereas the reviewer contract also permits `Partial`
and `Blocked`. It also requires at least one finding. B's stale executive
risk band is an example of a cross-projection inconsistency.

**Proposed change:** Keep Markdown normative, but derive summary risk tables
and handoff rankings from the threat catalogue instead of retyping bands.
Validate reciprocal threat/surface/control associations, all required
coverage dispositions, and review-status semantics. Prevent completion with
unresolved blocking review dimensions. Permit an explicit, fully documented
zero-findings review rather than requiring a fabricated finding.

**Proposed completion criterion:** Extend the existing synthetic fixtures in
`tests/validate-agent.sh` to reject a correct catalogue with a stale summary,
a one-sided coverage link, and an unresolved blocking review dimension.
An explicit completed zero-findings review should be representable without
implying approval. Preserve the existing arithmetic and reference checks.

### P1: Independently confirm material review corrections

**Established basis:** A records re-review after corrections; B's single-pass
limitation is explicit, and its current summary still conflicts with a
corrected risk record.

**Proposed change:** After material risk, evidence-credit, or coverage edits,
freeze the corrected projection and send a bounded closure pass to the
write-disabled reviewer. Require a disposition per original finding, with
references to the corrected model and evidence. Bind review input to the
exact model iteration/content identity, not just a mutable filename.
Preserve the original finding and append the closure history.

**Proposed completion criterion:** "All findings addressed" requires
reviewer-supported closure against the final projection, not merely the
orchestrator's edit log. Reuse a reviewer for focused closure when possible;
reserve an additional independent perspective for unresolved material
disagreements. Review closure remains distinct from human approval.

### P1: Check lifecycle and dependency coverage before synthesis

**Established basis:** Both scopes include the full target lifecycle and
host-side surfaces, but the resulting nested-trap, evaluator, and shutdown
coverage differs. Sources: both scopes and the coverage comparison above.

**Proposed change:** Build a scope-derived surface/lifecycle matrix before
writing threats. Include initialization, exceptional and nested paths,
transitions, shutdown/disposal, build inputs, evidence production, evaluator
exports, and human gates where applicable. Require a linked threat, a
reasoned non-goal, or an explicit unknown for each cell. Verify every
dependency assumption identifies the objective/threat affected if it fails.
Keep in-scope risks, scope-extension risks, and non-goals separate in totals.

**Proposed completion criterion:** A shutdown row or a nested-path unknown
cannot disappear merely because a model chooses a smaller set of flows.
A coverage disposition must be evidence-supported; a non-goal is not
misrepresented as an implemented mitigation.

### P2: Record the full experiment configuration

**Established basis:** Both runs used Sol specialists. The current three
specialist profiles explicitly name `gpt-5.6-sol`. A package name or requested
orchestrator model therefore does not identify the entire effective stack.

**Proposed change:** Record requested and observed models per role, agent and
skill versions, effective input identities, target/evidence revisions,
available tools, generation parameters when observable, and interruption or
restart events. Mark unavailable metadata Unknown. Explicitly choose whether
a comparison changes only the orchestrator or every role. Preserve the
independent-generation rule: prior analysis is available for comparison only
after both projections are frozen.

**Proposed completion criterion:** A reader can distinguish an
orchestrator-only comparison from a full-stack comparison without consulting
ephemeral session history. Evaluate matched scenarios and evidence support,
not raw threat counts. Any repeated comparison runs require a separately
agreed scope and budget; this proposal does not initiate them.

## Boundaries of this document

**Established:** The agent-improvement observations concern the repository
files read on 2026-09-06, principally `.github/agents/`,
`.github/skills/beryllium-threat-modeling/SKILL.md`, `AGENT-INTERFACE.md`,
`templates/`, `scripts/readonly-inspect.sh`,
`scripts/validate-threat-model.sh`, and `tests/validate-agent.sh`. No exact
agent-repository commit identity is asserted here.

**Unknown:** The comparison does not establish exploitability, hardware
behavior, correctness of every source observation, or a general ranking of
the underlying AI models. The tool-adapter implementation and runtime
enforcement integration remain design work.

**Established:** This is a private, standalone comparison, not a new TM
package or a successor model. Neither source package nor the agent
configuration is changed by its creation. Proposed agent work is separate
from target implementation, formal verification, human review approval,
publication, and risk acceptance.
