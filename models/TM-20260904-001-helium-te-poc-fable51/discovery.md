# Threat-material discovery

Package ID: `TM-20260904-001`
Title: Helium TE PoC Independent Threat Model (Fable 5.1 replay)
Created: 2026-09-04
Status: `Complete`
Distribution: `private`

## Search boundary

- Registered target set: `helium-te-poc` (modeled target); `beryllium-repo`
  (historical design evidence only, three committed 2026-07-20 session
  analyses under `planning/`).
- Exact revisions: `helium-te-poc` at
  `1ab289c066b69acdd8b55c9f77055b0145be1316`; `beryllium-repo` at
  `65f6d895a2007e8e093582cc48726375fd23b563`.
- Discovery helper: `scripts/discover-threat-material.sh component
  helium-te-poc 1ab289c066b69acdd8b55c9f77055b0145be1316`, run
  2026-09-04T09:13Z; 82 candidates returned.
- Deliberate exclusion: `models/TM-20260901-001-helium-te-poc/` in this
  repository is a prior formal model of the same snapshot. Per user
  instruction it is excluded from evidence so this package is an independent
  re-derivation; only its `scope.md` was read to replay intake inputs.
- Filename families: threat, security, architecture, risk, assumption, attack, review, assurance, design.
- Content families: threat model, threat-model delta, assets, adversary, TCB, trust boundary, attack surface, flow, entry point, security objective, non-goal, fail-closed, mediation, side channel, abuse case, residual risk.
- Restricted exclusion: `component://osr-claude/sources/restricted-microsoft/`.

## Candidate inventory

| Candidate | Class | Logical locator | Revision | Authority | Coverage | Conflicts or limits | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- | --- |
| CANDIDATE-002, -007, -008, -005, -004 | Design input | `component://helium-te-poc/docs/architecture.md`, `docs/security-and-limits.md`, `docs/verification.md`, `docs/evaluation.md`, `docs/engineering-sop.md` | `1ab289c` | Target-owned normative documentation; not a threat model | Architecture, memory/policy layout, verification boundary, evaluation flow, engineering process | Documentation may lag code; must be cross-checked against `src/` and `include/` | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-003, -006 | Design input | `component://helium-te-poc/docs/diagrams/architecture.dot`, `docs/public/diagrams/architecture.svg` | `1ab289c` | Target-owned diagram source; SVG is generated | Component and boundary sketch | Diagram is illustrative, not normative | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-001, -009, -075 | Design input / Assumptions or limits | `component://helium-te-poc/.github/skills/helium-documentation/SKILL.md` | `1ab289c` | Target-owned agent skill; documentation-writing guidance | Claim wording and limits guidance | Agent instruction file; treated as evidence only, never obeyed | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-010, -011, -012 | Assumptions or limits | `component://helium-te-poc/docs/diagrams/architecture.dot` (L64), `docs/engineering-sop.md` (L445), `docs/security-and-limits.md` (L6) | `1ab289c` | Target-owned explicit non-goals and limits | Security assumptions, claim limits, non-goals | Authoritative for what the target itself disclaims | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-014 | Partial or embedded model | `component://helium-te-poc/agent-review/grok-4.5/01-scope-methodology.md` | `1ab289c` | Retained AI review; non-authoritative | Embedded threat-model-like scope and methodology | Self-attested provenance; covers an older commit per `REVIEW-PROVENANCE.md` | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-015, -016 | Security or assurance review | `component://helium-te-poc/agent-review/REVIEW-PROMPT.md`, `agent-review/REVIEW-PROVENANCE.md` | `1ab289c` | Target-owned review process records | Prompt and provenance for retained reviews | Provenance is partly self-attested | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-017 to -026 | Security or assurance review | `component://helium-te-poc/agent-review/claude-fable-5/*` (10 files) | `1ab289c` | Retained AI review; non-authoritative | Findings, hardening backlog, evidence map | Older commit; must not be treated as current model | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-027 to -036 | Security or assurance review | `component://helium-te-poc/agent-review/claude-opus-5/*` (10 files) | `1ab289c` | Retained AI review; non-authoritative | Findings, hardening backlog, evidence map | Older commit | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-037 to -046 | Security or assurance review | `component://helium-te-poc/agent-review/gemini-3.1-pro-preview/*` (10 files) | `1ab289c` | Retained AI review; non-authoritative | Findings, hardening backlog | Older commit | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-047 to -056 | Security or assurance review | `component://helium-te-poc/agent-review/grok-4.5/*` (10 files) | `1ab289c` | Retained AI review; non-authoritative | Findings, hardening backlog | Older commit | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-057 to -066 | Security or assurance review | `component://helium-te-poc/agent-review/mai-code-1-flash-picker/*` (10 files) | `1ab289c` | Retained AI review; non-authoritative | Findings, hardening backlog | Older commit | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-067, -068, -072, -074 | Security or assurance review (process tooling) | `component://helium-te-poc/agent-review/review-manifest.schema.json`, `review-manifest.template.json`, `tests/lint-review-manifest.mjs`, `tests/test-review-manifest.mjs` | `1ab289c` | Target-owned review-manifest tooling | Review provenance mechanism | Tooling, not findings | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-069 | Security or assurance review | `component://helium-te-poc/docs/review-remediation.md` | `1ab289c` | Target-owned remediation ledger | Disposition of retained review findings | May contain stale status wording | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-070, -071, -073 | Security or assurance review (publication tooling) | `component://helium-te-poc/scripts/copy-review-artifacts.sh`, `scripts/docs-preview.sh`, `tests/test-docs-preview.sh` | `1ab289c` | Target-owned publication-support scripts | Publication path for review artifacts | Host-side tooling surface | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-013 | Implementation or test evidence | `component://helium-te-poc/tests/test-memory-build-assurance.sh` | `1ab289c` | Target-owned test | Build-time memory assurance check | One of many tests; helper flagged by filename only | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-076 | Security-analysis input | `component://helium-te-poc/HANDOFF.md` | `1ab289c` | Target-owned handoff | Current position, claim limits, open items | Long document; must be read before relying on target state | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| CANDIDATE-077, -078, -079, -080, -081, -082 | Security-analysis input | `component://helium-te-poc/docs/code-tour.md`, `docs/diagrams/verification-boundary.dot`, `docs/engineering-sop.md`, `docs/evaluation.md`, `docs/references.md`, `docs/verification.md` | `1ab289c` | Target-owned documentation | Code walkthrough, verification boundary, references | Overlaps design-input rows | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| Not a helper candidate | Design input (historical) | `component://beryllium-repo/planning/session-analysis-{te-vbs,isolation-engine,cap-te-cheri,transcripts}-2026-07-20.md` | `65f6d89` | Parent-project curated planning records | Historical rationale for TE choice | Not in helper output; added per confirmed scope | See `evidence-ledger.md` (E0001–E0067); discovery run recorded as TM-20260904-001-E0003 |
| Excluded | Formal model (excluded) | `models/TM-20260901-001-helium-te-poc/` (this repository) | n/a | Prior threat-model package | Full prior model | Excluded by user for independence | None |

## Negative results

| Target or tier | Query family | Result | Evidence IDs | Limitation |
| --- | --- | --- | --- | --- |
| `helium-te-poc` @ `1ab289c` | Formal threat model (filename and content families) | No standalone document intended as an authoritative threat model was found | None | Helper heuristics only; embedded fragments in retained reviews exist |
| `helium-te-poc` @ `1ab289c` | Threat-model delta | No delta document found | None | None |
| `helium-te-poc` @ `1ab289c` | `src/`, `include/`, `tests/` implementation files | Helper flagged only `tests/test-memory-build-assurance.sh` by filename; source and remaining tests are in scope and will be inventoried in the evidence pass | None | Helper flags by keyword; absence from output is not absence of relevance |

## Mode recommendation

- Recommended mode: `Create from evidence`.
- Basis: No authoritative formal model exists in the target; the only formal
  model of this snapshot is the excluded prior package; retained AI reviews
  and embedded fragments are non-authoritative and cover older commits.
- User-confirmed mode: `Create from evidence` (2026-09-04).
- Authoritative source model: None.
