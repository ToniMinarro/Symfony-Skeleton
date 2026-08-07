---
name: minarrolabs-review
description: Orchestrate Minarro Labs work through technical, commercial, user, product, quality, security, design and simplification reviewers, then return one proportionate consolidated decision.
---

# Minarro Labs Review

Use this skill for meaningful feature, fix, architecture, product, UX, business or PR work. The user should not need to invoke each perspective independently.

Read `AGENTS.base.md`, root `AGENTS.md` and relevant product documentation before reviewing.

## Independent reviewers

Use `.agents/roles/technical.md`, `commercial.md`, `user.md`, `product.md`, `quality.md`, `security.md`, `design.md` and `simplifier.md`.

When subagents/parallel delegation are available, give each applicable reviewer the same neutral context and do not reveal other reviewers' conclusions before it responds. When unavailable, perform isolated passes using the same contracts and reset assumptions between passes.

Scale depth proportionately, but always include Security for auth/tenancy/data-sensitive work, Design for meaningful UI work, and Simplifier for feature/architecture/infrastructure changes.

## Consolidation

Before implementation choose `GO`, `MODIFY` or `DO NOT BUILD`. After implementation/review choose `READY`, `READY WITH FOLLOW-UPS` or `CHANGES REQUIRED`.

Block only on concrete security/tenant boundary violations, data loss/corruption, correctness regressions, unsafe migrations, broken critical flows or missing critical validation. Keep architecture preference, commercial suggestions, product prioritization, design polish and simplification advisory unless they expose a concrete blocker.

Only expose individual reviewer notes when they conflict, identify material risk, or the user explicitly asks for the full council view.

For UI work also apply `product-design`. When implementation is requested, preserve repository workflow/traceability, validate the real flow and review the actual final behaviour before claiming completion.
