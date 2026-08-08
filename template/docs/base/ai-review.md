# Minarro Labs AI review

This shared Symfony-Skeleton capability gives Minarro Labs products multiple independent professional review lenses without making the operator manage multiple agents manually.

A normal request such as "add X", "fix Y", "improve this screen", "review this PR" or "is this worth building?" is enough. The agent reads `AGENTS.base.md`, product `AGENTS.md`, relevant docs and applies proportionate technical, commercial, user, product, quality, security, design and simplification review.

When subagents are supported, reviewer contracts under `.agents/roles/` should run independently with neutral context before consolidation. Otherwise isolated passes use the same contracts.

## Review moments

Before implementation, meaningful product work should distinguish facts from assumptions and answer:

1. What evidence supports the problem/value?
2. Is this a better use of product capacity than the strongest known alternative?
3. What is the smallest implementation or experiment that can validate value?
4. What observable signal would justify continuing, iterating or stopping?
5. Is customer discovery/manual validation cheaper than building first?
6. What security/quality constraints and simpler alternatives matter?

Return `GO`, `MODIFY`, `DO NOT BUILD` or `DO NOT BUILD YET`. `DO NOT BUILD YET` means the direction may be valid but evidence/timing does not justify implementation yet.

Before completion/merge, review the implementation itself and return `READY`, `READY WITH FOLLOW-UPS` or `CHANGES REQUIRED`, with blockers first.

Credible authorization/tenant bypass, sensitive-data exposure, data corruption/loss, materially incorrect behaviour, unsafe migrations, broken critical paths and missing critical validation are normally blocking. Subjective design/product/commercial/architecture preferences are advisory unless they reveal concrete risk.

## Product learning

For changes carrying a meaningful product/commercial hypothesis, keep a lightweight learning loop only when it will improve a future decision:

- hypothesis;
- expected signal;
- observed result;
- decision: continue, iterate, stop or revert.

Do not impose this on routine maintenance, bug fixes or trivial improvements. CI green validates implementation confidence; it does not prove user or market value.

User-facing changes always receive the product-design pass. The default output is synthesized rather than one essay per reviewer. Do not add new reviewer roles when the existing council can own the question clearly.
