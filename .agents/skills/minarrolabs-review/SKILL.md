---
name: minarrolabs-review
description: Orchestrate Minarro Labs work through technical, commercial, user, product, quality, security, design and simplification lenses, then return one proportionate consolidated decision.
---

# Minarro Labs Review

Use this skill for meaningful feature, fix, architecture, product, UX, business
or PR work in Minarro Labs repositories. It is an orchestration skill: the user
should not need to invoke each perspective independently.

## 1. Understand the real objective

Extract the requested outcome, affected users, current product constraints and
what evidence would prove the work useful. Read repository instructions and
product docs before inventing assumptions.

For meaningful product work, distinguish facts from assumptions. Capture the
minimum useful decision context: problem evidence, expected value, competing
priorities and the smallest validation step that could reduce uncertainty.

## 2. Run independent reviewers

Use the reviewer contracts in `.agents/roles/`:

- `technical.md`
- `commercial.md`
- `user.md`
- `product.md`
- `quality.md`
- `security.md`
- `design.md`
- `simplifier.md`

When the execution environment supports subagents or parallel delegation, send
the same neutral context to independent reviewer agents using those contracts.
Do not give them the other reviewers' conclusions before they respond. This is
preferred because it reduces anchoring and turns the council into genuinely
independent passes rather than one voice role-playing disagreement.

When subagent delegation is unavailable, perform isolated passes using the same
contracts. Reset assumptions between passes and avoid carrying a previous
reviewer's conclusion forward as fact.

Scale the number/depth of active reviewers proportionately for trivial work, but
always include Security for auth/tenancy/data-sensitive changes and Design for
meaningful user-facing changes. The Simplifier should run on features,
architecture and infrastructure changes.

Do not let technical feasibility substitute for product value, or product
enthusiasm suppress security/quality concerns. Do not create new reviewer roles
when the current contracts can own the question clearly.

## 3. Consolidate, do not role-play

Resolve the independent reviews into a single direction. Prefer the smallest
approach that preserves meaningful user/product value and credible
safety/correctness.

For meaningful feature proposals, consolidation must explicitly answer:

1. What evidence supports building this now?
2. Is this a better use of product capacity than the strongest known alternative?
3. What is the smallest implementation or experiment that can validate value?
4. What observable signal would justify continuing, iterating or stopping?
5. Is a manual/customer-discovery step cheaper than building first?

Insufficient evidence for a sizeable investment is a valid reason to recommend
`DO NOT BUILD YET` with a smaller validation action. This is different from a
permanent rejection.

Before implementation, choose:

- `GO`
- `MODIFY`
- `DO NOT BUILD`
- `DO NOT BUILD YET` when the direction may be valid but evidence/timing does
  not justify implementation yet.

After implementation/review, choose:

- `READY`
- `READY WITH FOLLOW-UPS`
- `CHANGES REQUIRED`

Only expose individual reviewer notes when they conflict, identify a material
risk, or the user explicitly asks for the full council view.

## 4. Severity

Block only on concrete high-value concerns such as security/tenant boundary
violations, data loss, correctness regressions, unsafe migrations, broken
critical flows or missing critical validation.

Keep architecture preference, commercial suggestions, design polish and
simplification ideas advisory unless they reveal a concrete blocker.

## 5. User-facing work

For any meaningful UI change, apply the `product-design` skill as part of this
review. Do not accept "works" as sufficient evidence of UI quality.

## 6. Product learning

For work that carries a meaningful product/commercial hypothesis, define a
lightweight learning loop only when it helps a future decision:

- hypothesis;
- expected signal;
- observed result;
- decision: continue, iterate, stop or revert.

Do not force this on routine maintenance, bug fixes or trivial improvements.
Passing CI validates implementation quality, not market/user value.

## 7. Execution behaviour

When the user asked to implement rather than merely advise:

- improve underspecified details using the review instead of stopping for
  avoidable clarification;
- create/maintain issue traceability when the repository workflow requires it;
- implement the revised scope;
- run relevant validation;
- review the actual diff/behaviour again before claiming completion;
- report blockers and unverified areas precisely.

Keep the user's interface simple: normal prompts in, consolidated useful work
out.
