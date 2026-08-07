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
enthusiasm suppress security/quality concerns.

## 3. Consolidate, do not role-play

Resolve the independent reviews into a single direction. Prefer the smallest
approach that preserves meaningful user/product value and credible
safety/correctness.

Before implementation, choose:

- `GO`
- `MODIFY`
- `DO NOT BUILD`

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

## 6. Execution behaviour

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
