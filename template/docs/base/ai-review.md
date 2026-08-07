# Minarro Labs AI review

This shared Symfony-Skeleton capability gives Minarro Labs products multiple independent professional review lenses without making the operator manage multiple agents manually.

A normal request such as "add X", "fix Y", "improve this screen", "review this PR" or "is this worth building?" is enough. The agent reads `AGENTS.base.md`, product `AGENTS.md`, relevant docs and applies proportionate technical, commercial, user, product, quality, security, design and simplification review.

When subagents are supported, reviewer contracts under `.agents/roles/` should run independently with neutral context before consolidation. Otherwise isolated passes use the same contracts.

## Review moments

Before implementation: identify the real problem, smallest valuable outcome, security/quality constraints, product fit and simpler alternatives; return `GO`, `MODIFY` or `DO NOT BUILD`.

Before completion/merge: review the implementation itself and return `READY`, `READY WITH FOLLOW-UPS` or `CHANGES REQUIRED`, with blockers first.

Credible authorization/tenant bypass, sensitive-data exposure, data corruption/loss, materially incorrect behaviour, unsafe migrations, broken critical paths and missing critical validation are normally blocking. Subjective design/product/commercial/architecture preferences are advisory unless they reveal concrete risk.

User-facing changes always receive the product-design pass. The default output is synthesized rather than one essay per reviewer.
