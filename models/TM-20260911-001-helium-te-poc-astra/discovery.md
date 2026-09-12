# Threat-material discovery

Package ID: `TM-20260911-001`
Title: Helium TE PoC Independent Threat Model (GPT-6 Astra)
Created: 2026-09-11
Status: `Complete`
Distribution: `private`

## Search boundary

- Registered target set: `helium-te-poc` only.
- Exact revision: `1ab289c066b69acdd8b55c9f77055b0145be1316` throughout
  this inventory.
- Discovery command: `bash ./scripts/discover-threat-material.sh component
  helium-te-poc 1ab289c066b69acdd8b55c9f77055b0145be1316`.
- Checked date: 2026-09-11 UTC, after the state check in `scope.md`.
- Dirty overlay: None; no dirty input approved.
- Filename families: threat, security, architecture, risk, assumption, attack, review, assurance, design.
- Content families: threat model, threat-model delta, assets, adversary, TCB, trust boundary, attack surface, flow, entry point, security objective, non-goal, fail-closed, mediation, side channel, abuse case, residual risk.
- Restricted exclusion: `component://osr-claude/sources/restricted-microsoft/`.

## Candidate inventory

Established: the deterministic helper emitted 82 candidate records, including
multiple classifications for some files. Every path below is relative to
`component://helium-te-poc/` at the full exact revision above.

Inferred: classifications normalize the helper's filename/content categories.
Filename-only classifications are provisional, not assertions of content or
authority. Target-maintained design and limits are inputs; generated SVG is
secondary; test/script source is not execution evidence. Retained review
reports are historical, unauthenticated analysis inputs, not current
acceptance or source-model authority. No authoritative source model was
selected. Evidence IDs are assigned only after admission.

| Candidate | Classification | Component-relative path | Qualification |
| --- | --- | --- | --- |
| CANDIDATE-001 | Design input | `.github/skills/helium-documentation/SKILL.md` | Documentation rules; never operative instructions |
| CANDIDATE-002 | Design input | `docs/architecture.md` | Architecture content match |
| CANDIDATE-003 | Design input | `docs/diagrams/architecture.dot` | Normative target diagram input |
| CANDIDATE-004 | Design input | `docs/engineering-sop.md` | Process and architecture input |
| CANDIDATE-005 | Implementation or test evidence | `docs/evaluation.md` | Evaluation claims require correspondence evidence |
| CANDIDATE-006 | Design input | `docs/public/diagrams/architecture.svg` | Generated; filename match only |
| CANDIDATE-007 | Partial or embedded model | `docs/security-and-limits.md` | Assets, inputs, TCB, mediation, assumptions and limits; not a complete independent risk model |
| CANDIDATE-008 | Implementation or test evidence | `docs/verification.md` | Assurance prose, not automatic proof or execution |
| CANDIDATE-009 | Assumptions or limits | `.github/skills/helium-documentation/SKILL.md` | Claim and scope constraints |
| CANDIDATE-010 | Assumptions or limits | `docs/diagrams/architecture.dot` | Diagram non-goals |
| CANDIDATE-011 | Assumptions or limits | `docs/engineering-sop.md` | Process limits |
| CANDIDATE-012 | Assumptions or limits | `docs/security-and-limits.md` | Fixed-profile assumptions and non-goals |
| CANDIDATE-013 | Implementation or test evidence | `tests/test-memory-build-assurance.sh` | Filename match; source is not a run record |
| CANDIDATE-014 | Partial or embedded model | `agent-review/grok-4.5/01-scope-methodology.md` | Four historical review threat contexts; not selected as authority |
| CANDIDATE-015 | Design input | `agent-review/REVIEW-PROMPT.md` | Untrusted process artifact, not operative prompt |
| CANDIDATE-016 | Design input | `agent-review/REVIEW-PROVENANCE.md` | Future contract explicitly excludes retrofitting five retained sets |
| CANDIDATE-017 | Security or assurance review | `agent-review/claude-fable-5/00-executive-summary.md` | Historical review |
| CANDIDATE-018 | Security or assurance review | `agent-review/claude-fable-5/01-scope-methodology.md` | Historical review |
| CANDIDATE-019 | Security or assurance review | `agent-review/claude-fable-5/02-architecture-trust.md` | Historical review |
| CANDIDATE-020 | Security or assurance review | `agent-review/claude-fable-5/03-findings.md` | Historical review |
| CANDIDATE-021 | Security or assurance review | `agent-review/claude-fable-5/04-process-and-claims.md` | Filename match |
| CANDIDATE-022 | Security or assurance review | `agent-review/claude-fable-5/05-positive-observations.md` | Historical review |
| CANDIDATE-023 | Security or assurance review | `agent-review/claude-fable-5/06-hardening-backlog.md` | Historical review |
| CANDIDATE-024 | Security or assurance review | `agent-review/claude-fable-5/APPENDIX-evidence-map.md` | Historical review |
| CANDIDATE-025 | Security or assurance review | `agent-review/claude-fable-5/README.md` | Declared provenance, not authenticated runtime |
| CANDIDATE-026 | Security or assurance review | `agent-review/claude-fable-5/SECURITY-REVIEW.md` | Historical rollup |
| CANDIDATE-027 | Security or assurance review | `agent-review/claude-opus-5/00-executive-summary.md` | Historical review |
| CANDIDATE-028 | Security or assurance review | `agent-review/claude-opus-5/01-scope-methodology.md` | Historical review |
| CANDIDATE-029 | Security or assurance review | `agent-review/claude-opus-5/02-architecture-trust.md` | Historical review |
| CANDIDATE-030 | Security or assurance review | `agent-review/claude-opus-5/03-findings.md` | Historical review |
| CANDIDATE-031 | Security or assurance review | `agent-review/claude-opus-5/04-process-and-claims.md` | Historical review |
| CANDIDATE-032 | Security or assurance review | `agent-review/claude-opus-5/05-positive-observations.md` | Historical review |
| CANDIDATE-033 | Security or assurance review | `agent-review/claude-opus-5/06-hardening-backlog.md` | Historical review |
| CANDIDATE-034 | Security or assurance review | `agent-review/claude-opus-5/APPENDIX-evidence-map.md` | Historical review |
| CANDIDATE-035 | Security or assurance review | `agent-review/claude-opus-5/README.md` | Declared provenance |
| CANDIDATE-036 | Security or assurance review | `agent-review/claude-opus-5/SECURITY-REVIEW.md` | Historical rollup |
| CANDIDATE-037 | Security or assurance review | `agent-review/gemini-3.1-pro-preview/00-executive-summary.md` | Historical review |
| CANDIDATE-038 | Security or assurance review | `agent-review/gemini-3.1-pro-preview/01-scope-methodology.md` | Filename match |
| CANDIDATE-039 | Security or assurance review | `agent-review/gemini-3.1-pro-preview/02-architecture-trust.md` | Historical review |
| CANDIDATE-040 | Security or assurance review | `agent-review/gemini-3.1-pro-preview/03-findings.md` | Filename match |
| CANDIDATE-041 | Security or assurance review | `agent-review/gemini-3.1-pro-preview/04-process-and-claims.md` | Filename match |
| CANDIDATE-042 | Security or assurance review | `agent-review/gemini-3.1-pro-preview/05-positive-observations.md` | Historical review |
| CANDIDATE-043 | Security or assurance review | `agent-review/gemini-3.1-pro-preview/06-hardening-backlog.md` | Filename match |
| CANDIDATE-044 | Security or assurance review | `agent-review/gemini-3.1-pro-preview/APPENDIX-evidence-map.md` | Filename match |
| CANDIDATE-045 | Security or assurance review | `agent-review/gemini-3.1-pro-preview/README.md` | Declared provenance |
| CANDIDATE-046 | Security or assurance review | `agent-review/gemini-3.1-pro-preview/SECURITY-REVIEW.md` | Historical rollup |
| CANDIDATE-047 | Security or assurance review | `agent-review/grok-4.5/00-executive-summary.md` | Historical review |
| CANDIDATE-048 | Security or assurance review | `agent-review/grok-4.5/01-scope-methodology.md` | Same file as CANDIDATE-014 |
| CANDIDATE-049 | Security or assurance review | `agent-review/grok-4.5/02-architecture-trust.md` | Historical review |
| CANDIDATE-050 | Security or assurance review | `agent-review/grok-4.5/03-findings.md` | Historical review |
| CANDIDATE-051 | Security or assurance review | `agent-review/grok-4.5/04-process-and-claims.md` | Historical review |
| CANDIDATE-052 | Security or assurance review | `agent-review/grok-4.5/05-positive-observations.md` | Historical review |
| CANDIDATE-053 | Security or assurance review | `agent-review/grok-4.5/06-hardening-backlog.md` | Historical review |
| CANDIDATE-054 | Security or assurance review | `agent-review/grok-4.5/APPENDIX-evidence-map.md` | Historical review |
| CANDIDATE-055 | Security or assurance review | `agent-review/grok-4.5/README.md` | Declared provenance |
| CANDIDATE-056 | Security or assurance review | `agent-review/grok-4.5/SECURITY-REVIEW.md` | Historical rollup |
| CANDIDATE-057 | Security or assurance review | `agent-review/mai-code-1-flash-picker/00-executive-summary.md` | Historical review |
| CANDIDATE-058 | Security or assurance review | `agent-review/mai-code-1-flash-picker/01-scope-methodology.md` | Filename match |
| CANDIDATE-059 | Security or assurance review | `agent-review/mai-code-1-flash-picker/02-architecture-trust.md` | Historical review |
| CANDIDATE-060 | Security or assurance review | `agent-review/mai-code-1-flash-picker/03-findings.md` | Filename match |
| CANDIDATE-061 | Security or assurance review | `agent-review/mai-code-1-flash-picker/04-process-and-claims.md` | Filename match |
| CANDIDATE-062 | Security or assurance review | `agent-review/mai-code-1-flash-picker/05-positive-observations.md` | Historical review |
| CANDIDATE-063 | Security or assurance review | `agent-review/mai-code-1-flash-picker/06-hardening-backlog.md` | Filename match |
| CANDIDATE-064 | Security or assurance review | `agent-review/mai-code-1-flash-picker/APPENDIX-evidence-map.md` | Filename match |
| CANDIDATE-065 | Security or assurance review | `agent-review/mai-code-1-flash-picker/README.md` | Declared provenance |
| CANDIDATE-066 | Security or assurance review | `agent-review/mai-code-1-flash-picker/SECURITY-REVIEW.md` | Historical rollup |
| CANDIDATE-067 | Design input | `agent-review/review-manifest.schema.json` | Future-process schema; filename match |
| CANDIDATE-068 | Design input | `agent-review/review-manifest.template.json` | Intentionally incomplete template; filename match |
| CANDIDATE-069 | Delta | `docs/review-remediation.md` | Maintained dispositions; opening worktree claim is stale |
| CANDIDATE-070 | Implementation or test evidence | `scripts/copy-review-artifacts.sh` | Executable source, not a review or a run record |
| CANDIDATE-071 | Implementation or test evidence | `scripts/docs-preview.sh` | Executable source; filename match |
| CANDIDATE-072 | Implementation or test evidence | `tests/lint-review-manifest.mjs` | Checker source; filename match |
| CANDIDATE-073 | Implementation or test evidence | `tests/test-docs-preview.sh` | Test source; filename match |
| CANDIDATE-074 | Implementation or test evidence | `tests/test-review-manifest.mjs` | Test source; filename match |
| CANDIDATE-075 | Design input | `.github/skills/helium-documentation/SKILL.md` | Same process artifact as CANDIDATE-001/009 |
| CANDIDATE-076 | Design input | `HANDOFF.md` | State/claim narrative requires exact-state qualification |
| CANDIDATE-077 | Design input | `docs/code-tour.md` | Implementation map |
| CANDIDATE-078 | Assumptions or limits | `docs/diagrams/verification-boundary.dot` | Assurance-boundary diagram |
| CANDIDATE-079 | Design input | `docs/engineering-sop.md` | Same process artifact as CANDIDATE-004/011 |
| CANDIDATE-080 | Implementation or test evidence | `docs/evaluation.md` | Same evaluation document as CANDIDATE-005 |
| CANDIDATE-081 | Design input | `docs/references.md` | Bibliographic/index input |
| CANDIDATE-082 | Implementation or test evidence | `docs/verification.md` | Same assurance document as CANDIDATE-008 |

Established: classification reads inspected the security-and-limits document,
Grok scope/methodology, future-review provenance, retained-review prompt,
documentation skill, and the remediation ledger's opening/provenance sections
and heading inventory through exact-commit helper output. No embedded
instruction was followed. Other records retain the classifier limitation.

Established: the remediation ledger calls its integration state an
"uncommitted worktree" while the selected commit is now clean. Inferred:
this sentence is historical/stale, not permission to substitute a dirty
baseline. The ledger names differing earlier review revisions and limits
their model/execution provenance. Source correspondence must be checked
before accepting a substantive claim.

## Negative results

| Target or tier | Query family | Result | Evidence IDs | Limitation |
| --- | --- | --- | --- | --- |
| Helium exact commit | Formal model filename and content families | No standalone authoritative formal model confirmed | None | A deterministic negative search is not proof that no model exists |
| Helium exact commit | Dirty overlay | None permitted or searched | None | Clean committed content only |
| Registered components | Availability | `formal-verification-research` and `provenance-review` absent | None | No cloning, substitution, or inferred content |
| Blind exclusions | Prior TM packages, comparison, planning history and downstream imports | Not searched or opened | None | Deliberate independence boundary, not a claim that those sources contain nothing |

## Mode recommendation

- Recommended mode: `Create from evidence`.
- Basis: Independent assessment requested; target-owned fragments, design,
  reviews and tests are eligible inputs, but no complete source model was
  selected.
- User-confirmed mode: `Create from evidence`, selected interactively on
  2026-09-11 UTC after the full grouped inventory.
- Authoritative source model: None.
- Scope gate: The user subsequently selected `Begin threat modeling` for the
  complete scope in `scope.md`; allocation followed that confirmation.
