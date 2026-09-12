# Completed blind analysis freeze

Package ID: `TM-20260911-001`
Title: Helium TE PoC Independent Threat Model (GPT-6 Astra)
Created: 2026-09-11
Status: `Complete`
Distribution: `private`

## Freeze declaration

Established: the new source-led model and its independent Astra review are
complete. All three modeling findings were corrected and independently closed
in REVIEW-ITERATION-002; no remaining modeling blocker or blocking user
question was identified. The completed model is MODEL-ITERATION-002.
The first numbered model/review iterations and retained diagram sources
remain unchanged. TM-20260911-001-E0045, TM-20260911-001-E0046.

Established: maintained completion validation and diagram rendering
succeeded before this checkpoint. The hashes below were observed through the
maintained inspector at 2026-09-11T22:45:58Z-22:45:59Z. No earlier TM package,
earlier run-comparison analysis or excluded planning-session history informed
this model or its review. Target-owned historical reviews were deliberately
eligible and are not confused with the excluded threat-modeler packages.

Established: target remains Helium
`1ab289c066b69acdd8b55c9f77055b0145be1316`, clean/detached, with Beryllium
`65f6d895a2007e8e093582cc48726375fd23b563` clean on
`beryllium/single-hart-runtime-r0` as historical context only, last
rechecked at 2026-09-11T22:40:33Z. No target execution, dirty overlay, scope
expansion, implementation change or human decision was introduced.

## Immutable analytical baseline

The baseline is the following expanded/normalized model, current/numbered
reviews, 46-record admitted evidence set and seven normative diagrams.
Operational activity, index and comparison records are separate. No
comparison-informed change may modify these baseline files or earlier
iterations; any future successor must be separately labeled.

| Package-relative file | SHA-256 |
| --- | --- |
| `threat-model.md` | `982f93693099f511492b7e5404389200ffba4da5d9315877d9654a18fc803fe4` |
| `review.md` | `8c1752c1c6987614369f92460ebd1a46291dd42b175b416481a6642ec9646bc2` |
| `evidence-ledger.md` | `4f0d087757c5f35940a61e0598620ee2b4b5849591f96636b967d72c33a9aa9b` |
| `iterations/MODEL-ITERATION-001.md` | `6a82dd6414931efc191fa9519758abf89f8b943191681cd8aa5b56b4c9985d0b` |
| `iterations/MODEL-ITERATION-002.md` | `4b50447af43934d209ab9e31f67649b807d010fed6442c1bf029d38cdd071fe6` |
| `iterations/REVIEW-ITERATION-001.md` | `6bb00aee74d37225a125c884bc62b9fabeba93d2d3b89dee016c11090e81f1b3` |
| `iterations/REVIEW-ITERATION-002.md` | `cf0f84511a3427bc79de047648a56585694f071d6583898380a725194c58dda6` |
| `diagrams/system-context.dot` | `23ebacca7edcf8eacbc7dc06f4c6bd6e0e033bb8cfac8c0f99e792e1b5aa00d3` |
| `diagrams/trust-boundaries.dot` | `91533033d3fcb3de31eb57bdc159bec4b3a546c29f98f3efb811a45ffd9e501f` |
| `diagrams/data-flows.dot` | `a85fd2e53be0d72127066393983f19e96b38ff85b4030c25eae7c05c2d129474` |
| `diagrams/attack-tree-001.dot` | `ec6f6c4a87ea9a19e7beaef286d8ac6216a9d5cc6a5dffe4451e75f5c64fb16b` |
| `diagrams/attack-tree-002.dot` | `fb0e6d0c35fbd6e1628f47c4ffedeeba31440e04422ee71ea029a26dd4480d79` |
| `diagrams/attack-tree-003.dot` | `2b00913150f82cc3d341840dd47da649993f63969d688a2cb83cef05518ed4ee` |
| `diagrams/attack-tree-004.dot` | `9efbadcac784fb96dafc0ec43e412e6e1eb9918e5bd1dd35b29efdec76762dc8` |

Established: current expanded-model changes after closure were workflow
annotations only; reviewed threat data and the normalized MODEL-ITERATION-002
did not change. That iteration records its pre-closure candidate state;
REVIEW-ITERATION-002 supplies the later closure, without rewriting history.
Retained current DOT locations are mapped in REVIEW-INPUT-002.md.
Superseded first-iteration context/boundary/data/attack-003/004 copies were
rehashed and matched REVIEW-INPUT-001.md at this checkpoint.

## Boundaries and remaining gates

Established: freeze means an orchestrator-held append-only analytical
baseline with maintained hash observations. No filesystem-enforced
immutability, Git commit, baseline-copy validator run, provider attestation,
formal verification or human approval is claimed.

Unknown: OPEN-002/005/006/007/008/010 continue to constrain stronger claims.
Six conditional risks remain High 12/25; the permitted-output scenario is
Moderate 9/25 and depends on three unestablished conditions. Source-led
model completion is neither target security assurance nor risk acceptance.

Established: repository index regeneration and agent-contract checks still
follow this analytical freeze. Earlier-model comparison will begin only
after those maintained checks also succeed and will be recorded separately
in RUN-COMPARISON.md. Distribution remains private; no human-promotion record
has been completed.

## Completion gate outcome

Established: after the analytical freeze and before opening earlier model
content, `scripts/update-index.sh` regenerated THREAT-MODELS.md and
`tests/validate-agent.sh` passed all 159 checks with zero failures. The
package-specific maintained completion validator had already succeeded.
The helper tests exercised only their synthetic fixtures, not target code.
All required private-package completion gates have now succeeded.

Established: post-freeze comparison may now proceed as separately requested.
It will not change any baseline hash-bound model, review, evidence, numbered
iteration or normative diagram. The comparison is not an independent
revalidation of earlier packages or a controlled experiment attributing
differences solely to a model.

## Post-comparison preservation

Established: at 2026-09-11T23:00:18Z, all fourteen hash-bound analytical files
above exactly matched this pre-comparison baseline. Both target/context heads
remained exact and clean. The comparison's eleven older source-document
hashes also remained unchanged. Maintained completion validation and index
checking passed after the separate comparison was added.

Established: RUN-COMPARISON.md is the sole comparison analysis. Operational
activity/handoff records describe its completion, but no comparison-informed
content entered the frozen model, review, evidence ledger, numbered
iterations or normative DOT.
