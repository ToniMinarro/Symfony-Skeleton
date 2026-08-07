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

## 2. Run independent lenses

Assess the request independently from these perspectives:

- Technical: correctness, architecture, maintainability, performance, operations.
- Commercial: sellability, demonstration value, retention, pricing/delivery cost.
- User: task success, speed, comprehension, cognitive load, accessibility.
- Product: priority, outcome, scope, dependencies, smallest useful version.
- Quality: failures, edge cases, regression risk, tests, observability/support.
- Security: trust boundaries, authz, tenancy, data/secrets, abuse, secure defaults.
- Design: hierarchy, interactions, consistency, responsive/accessibility/states.
- Simplifier: remove scope and reject speculative abstractions/infrastructure.

Do not let one lens prime all the others. In particular, do not let technical
feasibility substitute for product value, or product enthusiasm suppress
security/quality concerns.

## 3. Consolidate, do not role-play

Resolve the perspectives into a single direction. Prefer the smallest approach
that preserves meaningful user/product value and credible safety/correctness.

Before implementation, choose:

- `GO`
- `MODIFY`
- `DO NOT BUILD`

After implementation/review, choose:

- `READY`
- `READY WITH FOLLOW-UPS`
- `CHANGES REQUIRED`

Only expose individual lens notes when they conflict, identify a material risk,
or the user explicitly asks for the full council view.

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
