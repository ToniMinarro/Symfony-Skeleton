# Minarro Labs AI review

This document defines the reusable decision and review system for Minarro Labs
projects. Its goal is not to simulate a large company. Its goal is to make one
operator benefit from several independent professional lenses without adding
friction to normal work.

## Principle: transparent by default

A normal request is enough:

- "Add X."
- "Fix Y."
- "Is this feature worth building?"
- "Improve this screen."
- "Review this PR."

The agent must infer the relevant review depth, apply the perspectives from
`AGENTS.md`, and return or implement one consolidated answer. The operator
should not need to ask Tech, Product, QA, Security, Design, etc. separately.

Explicit requests such as "give me the full council review" may expose each
perspective, but that is an inspection mode rather than the default interface.

## The review council

### Technical

Focus on correctness of the technical direction: architecture, domain model,
framework fit, maintainability, performance, migrations, operations and debt.
The technical reviewer must not reward complexity for its own sake.

### Commercial

Ask whether the change helps the product be sold, demonstrated, priced,
retained or delivered more efficiently. For internal engineering work, only
raise commercial findings when there is a real cost or delivery consequence.

### User

Represent the person performing the task. Evaluate speed, comprehension,
cognitive load, accessibility, error prevention/recovery and whether the user's
actual problem improves.

### Product

Challenge priority and scope. Identify the expected outcome, what evidence would
show value, dependencies and the smallest useful version. A technically sound
feature may still be a poor product decision.

### Quality

Identify failure modes, regression surface, edge cases, test levels,
observability and operational/support concerns. Prefer tests that buy confidence
over tests that merely increase count.

### Security

Review trust boundaries, authentication/authorization, tenant isolation, secret
handling, input/output safety, data exposure, abuse cases, destructive actions,
dependency/configuration risk and secure defaults.

### Design

For user-facing changes, review information architecture, visual hierarchy,
interaction cost, consistency, responsive behaviour, accessibility and all key
states. Design quality is part of product quality, not optional polish.

### Simplifier

Try to delete scope. Ask what can be omitted, deferred, made synchronous,
implemented with framework defaults or validated manually before creating a new
abstraction. Raise `OVERENGINEERING WARNING` when complexity exceeds demonstrated
need.

## Two review moments

### Before implementation

For meaningful features and product decisions, answer these questions before
committing to the solution:

1. What user/business problem are we solving?
2. What is the smallest outcome that materially improves it?
3. What are the principal security/quality constraints?
4. Does this fit the current product direction?
5. Is there a simpler approach that preserves the value?

The result should be one of:

- `GO` — scope and approach are justified.
- `MODIFY` — useful work, but scope or approach should change.
- `DO NOT BUILD` — insufficient value, wrong timing or unjustified complexity.

Agents may proceed with `MODIFY` using the improved scope when the user's intent
is clear; do not create unnecessary confirmation loops.

### Before completion/merge

Review the actual implementation, not the original intention. Consolidate into:

- **Blockers** — must be fixed before completion.
- **Important** — meaningful improvements with clear value.
- **Optional** — worthwhile but safe to defer.
- **Verdict** — `READY`, `READY WITH FOLLOW-UPS`, or `CHANGES REQUIRED`.

## Blocking policy

A finding is normally blocking when it creates credible risk of:

- authorization or tenant-boundary bypass;
- secret or sensitive-data exposure;
- data corruption/loss or unsafe destructive behaviour;
- materially incorrect behaviour or regression;
- a migration/upgrade path that can break supported deployments;
- missing validation for a critical path;
- inaccessible core interaction where accessibility is a requirement of the
  feature or existing product baseline.

Do not make subjective style, theoretical scalability, commercial preference or
minor design polish block CI/merge by default.

## Design review standard

Every meaningful user-facing change should consider:

1. Primary task and primary action.
2. Information hierarchy and terminology from the user's domain.
3. Navigation and interaction cost.
4. Reuse of existing components/tokens/patterns.
5. Responsive behaviour and touch targets.
6. Keyboard and focus behaviour.
7. Empty, loading, validation, error, success and disabled states.
8. Destructive-action safeguards.
9. Perceived quality: spacing, rhythm, typography, alignment and visual noise.
10. Evidence (screenshots/preview/manual exercise) when feasible.

A design pass should improve the screen, not trigger gratuitous redesigns.
Preserve familiarity unless a change solves a real usability or consistency
problem.

## Output contract

The default response should be concise and synthesized. A recommended shape is:

```text
Decision: GO / MODIFY / DO NOT BUILD

What matters
- ...

Risks / blockers
- ...

Implementation direction
- ...

Validation
- ...
```

For completed code or PR reviews:

```text
Verdict: READY / READY WITH FOLLOW-UPS / CHANGES REQUIRED

Blockers
- ...

Important
- ...

Optional
- ...
```

Do not emit empty sections and do not produce one paragraph per role just to
prove that each role ran.

## Product-specific specialization

Downstream repositories inherit this baseline and should add only real product
constraints to their root `AGENTS.md`, for example:

- critical user journeys and performance budgets;
- multi-tenant/security boundaries;
- pilot/MVP priorities;
- domain terminology;
- design constraints or supported devices;
- evidence required before a feature can be considered complete.

The common perspectives should not be copied and drift independently when a
project can instead point back to this baseline.
