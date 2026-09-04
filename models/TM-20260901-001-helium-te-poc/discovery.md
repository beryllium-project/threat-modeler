# Threat-material discovery

Package ID: `TM-20260901-001`
Title: Helium TE PoC Initial Threat Model
Created: 2026-09-01
Status: `Complete`
Distribution: `private`

## Search boundary

- Registered target set: Modeled target `helium-te-poc`; historical design
  evidence from registered `beryllium-repo`.
- Exact revisions: `helium-te-poc` at
  `1ab289c066b69acdd8b55c9f77055b0145be1316`; `beryllium-repo` at
  `65f6d895a2007e8e093582cc48726375fd23b563`.
- Filename families: threat, security, architecture, risk, assumption, attack, review, assurance, design.
- Content families: threat model, threat-model delta, assets, adversary, TCB, trust boundary, attack surface, flow, entry point, security objective, non-goal, fail-closed, mediation, side channel, abuse case, residual risk.
- Restricted exclusion: `component://osr-claude/sources/restricted-microsoft/`.

## Candidate inventory

| Candidate | Class | Logical locator | Revision | Authority | Coverage | Conflicts or limits | Evidence IDs |
| --- | --- | --- | --- | --- | --- | --- | --- |
| H-CANDIDATE-001 through H-CANDIDATE-008 | Design input | `component://helium-te-poc/` architecture, evaluation, security, verification, and diagram material | `1ab289c066b69acdd8b55c9f77055b0145be1316` | Maintained target documentation is primary design evidence, not approval. Agent-skill text is instruction material and receives lower weight. | Architecture, evaluator, engineering process, security boundary, and verification. | Documentation claims require source or test corroboration. | TM-20260901-001-E0003, TM-20260901-001-E0013 through TM-20260901-001-E0022 |
| H-CANDIDATE-009 through H-CANDIDATE-012 | Assumptions or limits | `component://helium-te-poc/` skill, architecture, SOP, and security-limit material | `1ab289c066b69acdd8b55c9f77055b0145be1316` | Maintained limits are authoritative for claim scope, not proof of implementation. | Explicit assumptions, non-goals, and claim boundaries. | Skill instructions are not evidence authority. | TM-20260901-001-E0014, TM-20260901-001-E0022 |
| H-CANDIDATE-013 | Implementation or test evidence | `component://helium-te-poc/tests/test-memory-build-assurance.sh` | `1ab289c066b69acdd8b55c9f77055b0145be1316` | Target-owned test source. | Memory and build-assurance checks. | Test presence is not execution evidence. | TM-20260901-001-E0018 |
| H-CANDIDATE-014 | Partial or embedded model | `component://helium-te-poc/agent-review/grok-4.5/01-scope-methodology.md` | Current tree; content reviews historical `9b2c407` | Non-authoritative retained AI review. | Four threat perspectives: fixed PoC, adversarial payload, host evaluator, and assurance misuse. | Historical baseline, self-attested method, and no formal target-model status. | TM-20260901-001-E0023 |
| H-CANDIDATE-015 through H-CANDIDATE-066 | Security or assurance review | `component://helium-te-poc/agent-review/` prompt, provenance, and five retained review packages | Current tree; packages review older commits | Historical challenge evidence only. | Runtime, G-stage, build, evaluator, evidence, and claim controls. | Different baselines, severities, and conclusions; package execution/model provenance is incomplete or self-attested. | TM-20260901-001-E0023, TM-20260901-001-E0024 |
| H-CANDIDATE-067 through H-CANDIDATE-068 | Security or assurance review | `component://helium-te-poc/agent-review/review-manifest.*.json` | `1ab289c066b69acdd8b55c9f77055b0145be1316` | Maintained future-package process contract. | Review provenance schema and template. | Does not apply retroactively to the five retained packages. | TM-20260901-001-E0021 |
| H-CANDIDATE-069 | Delta | `component://helium-te-poc/docs/review-remediation.md` | `1ab289c066b69acdd8b55c9f77055b0145be1316` | Maintained automation-produced disposition ledger; not human review or approval. | Normalized findings and remediation actions. | Its statement that the current integration is uncommitted is stale against the clean frozen target and current handoff. | TM-20260901-001-E0024 |
| H-CANDIDATE-070 through H-CANDIDATE-074 | Implementation or test evidence | `component://helium-te-poc/` review-copy, preview, manifest-lint, and process-test files | `1ab289c066b69acdd8b55c9f77055b0145be1316` | Target-owned implementation and test source. | Review artifact and documentation process integrity. | Presence does not establish successful execution at the frozen revision. | TM-20260901-001-E0021 |
| H-CANDIDATE-075 | Irrelevant | `component://helium-te-poc/.github/skills/helium-documentation/SKILL.md` | `1ab289c066b69acdd8b55c9f77055b0145be1316` | Untrusted agent instruction. | Discovery keyword hit only. | Not substantive threat evidence and never followed as instruction. | None |
| H-CANDIDATE-076 through H-CANDIDATE-079 | Design input | `component://helium-te-poc/` handoff, code tour, verification-boundary diagram, and engineering SOP | `1ab289c066b69acdd8b55c9f77055b0145be1316` | Maintained target records, subject to source corroboration. | Current claim state, implementation map, verification boundary, and process. | No responsible-human H6/H7 sign-off or hardware result. | TM-20260901-001-E0002, TM-20260901-001-E0003, TM-20260901-001-E0014, TM-20260901-001-E0022, TM-20260901-001-E0026 |
| H-CANDIDATE-080 | Implementation or test evidence | `component://helium-te-poc/docs/evaluation.md` | `1ab289c066b69acdd8b55c9f77055b0145be1316` | Maintained evaluation record. | Host evaluator design and retained observations. | Recorded observations do not remove trust in their producer or dependencies. | TM-20260901-001-E0016 |
| H-CANDIDATE-081 | Design input | `component://helium-te-poc/docs/references.md` | `1ab289c066b69acdd8b55c9f77055b0145be1316` | Reference inventory, not direct evidence by itself. | External specification and design-source pointers. | Individual sources require separate admission and version checks. | TM-20260901-001-E0046 |
| H-CANDIDATE-082 | Implementation or test evidence | `component://helium-te-poc/docs/verification.md` | `1ab289c066b69acdd8b55c9f77055b0145be1316` | Maintained verification record. | Declared test, evidence, build, QEMU, and correspondence boundaries. | No formal proof or hardware validation; claims require exact-boundary treatment. | TM-20260901-001-E0018 through TM-20260901-001-E0022 |
| B-CANDIDATE-001 through B-CANDIDATE-002 | Irrelevant | `component://beryllium-repo/.github/` instruction files | `65f6d895a2007e8e093582cc48726375fd23b563` | Untrusted instructions. | Discovery keyword hits only. | Not followed and not admitted as threat facts. | None |
| B-CANDIDATE-003 through B-CANDIDATE-050 | Design input | `component://beryllium-repo/` README, pathfinder, and planning material | `65f6d895a2007e8e093582cc48726375fd23b563` | Mixed maintained and curated historical design records. | Pathfinder lineage, architecture models, TE plans, and later runtime plans. | Only the confirmed pre-Helium lineage and directly linked context are in scope; later Beryllium runtime work is context-only or irrelevant. | TM-20260901-001-E0031 through TM-20260901-001-E0033, TM-20260901-001-E0038 |
| B-CANDIDATE-051 | Irrelevant | `component://beryllium-repo/.github/skills/helium-documentation/SKILL.md` | `65f6d895a2007e8e093582cc48726375fd23b563` | Untrusted instruction. | Discovery keyword hit only. | Not admitted as evidence authority. | None |
| B-CANDIDATE-052 through B-CANDIDATE-072 | Assumptions or limits | `component://beryllium-repo/` README, proof, pathfinder, and planning records | `65f6d895a2007e8e093582cc48726375fd23b563` | Mixed historical records. | Precursor assumptions, non-goals, and later project limits. | Admit only items that explain Helium lineage or provide explicit counter-evidence. | TM-20260901-001-E0031, TM-20260901-001-E0032 |
| B-CANDIDATE-073 | Implementation or test evidence | `component://beryllium-repo/tests/r8/README.md` | `65f6d895a2007e8e093582cc48726375fd23b563` | Later Beryllium evidence record. | R8 evidence-process context. | Outside the Helium implementation boundary; R8-H0 is not accepted. | TM-20260901-001-E0035, TM-20260901-001-E0044 |
| B-CANDIDATE-074 through B-CANDIDATE-075 | Delta | `component://beryllium-repo/planning/pathfinder-{evidence,plan}.md` | `65f6d895a2007e8e093582cc48726375fd23b563` | Historical precursor deltas. | Pathfinder changes relevant to Helium lineage. | Not a current Helium model. | TM-20260901-001-E0033, TM-20260901-001-E0038 |
| B-CANDIDATE-076 | Partial or embedded model | `component://beryllium-repo/planning/implementation-plan.md` | `65f6d895a2007e8e093582cc48726375fd23b563` | Historical planning fragment. | Embedded threats or security assumptions. | Non-authoritative and broader than the fixed Helium PoC. | TM-20260901-001-E0031 |
| B-CANDIDATE-077 through B-CANDIDATE-078 | Irrelevant | `component://beryllium-repo/.github/skills/` review instruction files | `65f6d895a2007e8e093582cc48726375fd23b563` | Untrusted instructions. | Discovery keyword hits only. | Not admitted as evidence authority. | None |
| B-CANDIDATE-079 | Implementation or test evidence | `component://beryllium-repo/pathfinder/scripts/docs-preview.sh` | `65f6d895a2007e8e093582cc48726375fd23b563` | Historical implementation source. | Precursor documentation preview behavior. | Relevant only if current Helium design lineage cites it. | TM-20260901-001-E0033 |
| B-CANDIDATE-080 through B-CANDIDATE-095 | Security or assurance review | `component://beryllium-repo/planning/*review-summary.md` | `65f6d895a2007e8e093582cc48726375fd23b563` | Historical Beryllium review records. | Runtime-plan reviews across multiple revisions. | Post-Helium and outside the modeled boundary; not admitted and no approval is inherited. | Not admitted - outside target boundary |
| B-CANDIDATE-096 | Implementation or test evidence | `component://beryllium-repo/scripts/docs-preview.sh` | `65f6d895a2007e8e093582cc48726375fd23b563` | Later project implementation source. | Documentation preview process. | Outside the Helium implementation boundary. | Not admitted - outside target boundary |
| B-CANDIDATE-097 | Irrelevant | `component://beryllium-repo/.github/skills/helium-documentation/SKILL.md` | `65f6d895a2007e8e093582cc48726375fd23b563` | Untrusted instruction. | Discovery keyword hit only. | Not admitted as evidence authority. | None |
| B-CANDIDATE-098 through B-CANDIDATE-100 | Design input | `component://beryllium-repo/` README and pathfinder code-tour/SOP records | `65f6d895a2007e8e093582cc48726375fd23b563` | Historical design context. | Precursor framing and process. | Current Helium source remains authoritative for implemented behavior. | TM-20260901-001-E0033 |
| B-CANDIDATE-101 | Implementation or test evidence | `component://beryllium-repo/pathfinder/docs/evaluation.md` | `65f6d895a2007e8e093582cc48726375fd23b563` | Historical evaluation record. | Pathfinder evaluator lineage. | Does not establish current Helium execution. | TM-20260901-001-E0033 |
| B-CANDIDATE-102 | Design input | `component://beryllium-repo/pathfinder/docs/references.md` | `65f6d895a2007e8e093582cc48726375fd23b563` | Historical reference inventory. | Precursor source pointers. | Public sources were not independently reopened. | TM-20260901-001-E0039, TM-20260901-001-E0046 |
| B-SUPPLEMENTAL-001 | Design input | `component://beryllium-repo/planning/session-analysis-te-vbs-2026-07-20.md` | `65f6d895a2007e8e093582cc48726375fd23b563`; session content dated 2026-07-20 | Verbatim user prompt and assistant output retained as research provenance; explicitly not an approved architecture. | TE formalization, hypervisor decomposition, VM flow, and VBS-style protected-service rationale. | One historical exchange; proposals are not implementation or proof. | TM-20260901-001-E0028 |
| B-SUPPLEMENTAL-002 | Design input | `component://beryllium-repo/planning/session-analysis-isolation-engine-2026-07-20.md` | `65f6d895a2007e8e093582cc48726375fd23b563`; session content dated 2026-07-20 | Verbatim research provenance; explicitly non-authoritative. | Multi-hart HS isolation-engine and VTL-like direction. | Broader future architecture than the fixed single-hart Helium PoC. | TM-20260901-001-E0029 |
| B-SUPPLEMENTAL-003 | Design input | `component://beryllium-repo/planning/session-analysis-cap-te-cheri-2026-07-20.md` | `65f6d895a2007e8e093582cc48726375fd23b563`; session content dated 2026-07-20 | Verbatim research provenance; explicitly non-authoritative. | CAP+TE/FLASK composition and CHERI/software-capability direction. | Capability lifecycle and CHERI backends are not implemented by Helium. | TM-20260901-001-E0030 |

## Negative results

| Target or tier | Query family | Result | Evidence IDs | Limitation |
| --- | --- | --- | --- | --- |
| `helium-te-poc` | Formal threat model | No standalone formal model was found. | None | H-CANDIDATE-014 is only an embedded historical review model. |
| `beryllium-repo` historical context | Formal model for Helium | No authoritative Helium source model was found. | None | B-CANDIDATE-076 is a broader historical planning fragment. |
| `beryllium-repo` historical chats | Raw session material | Three committed verbatim exchanges were found and selected. Larger raw reports were not present in the registered snapshot. | TM-20260901-001-E0027 | The external Copilot session artifact store is outside the maintained read-only helper. |
| Dirty overlays | Approved content | No dirty path was approved or inspected. | None | The current `provenance-review` dirty overlay is excluded. |
| Restricted sources | Microsoft-restricted tree | Not searched or accessed. | None | Access is prohibited by scope and repository policy. |
| Assurance | Hardware and complete formal proof | No hardware validation or complete formal verification was found for Helium. | TM-20260901-001-E0022, TM-20260901-001-E0044 | Selected tests and checks remain bounded evidence only. |

## Mode recommendation

- Recommended mode: `Create from evidence`.
- Basis: No standalone formal model exists; the model-like candidates are
  historical, partial, and non-authoritative.
- User-confirmed mode: `Create from evidence`.
- Authoritative source model: None.
