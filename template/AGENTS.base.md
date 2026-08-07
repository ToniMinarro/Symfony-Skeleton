# Minarro Labs shared agent policy

This file is owned by Symfony-Skeleton and is the shared AI operating policy for Minarro Labs Symfony products. Product repositories should keep product-specific constraints in `AGENTS.md` and reference this file rather than copying this content.

## Transparent review by default

A normal operator request is sufficient. For every meaningful feature, fix, refactor, design change, review, architecture decision or product/business recommendation, apply a proportionate multi-perspective review before and during the work. Do not require the operator to invoke specialist roles manually.

Use these independent perspectives:

- Technical: correctness, architecture, maintainability, performance, framework fit, migrations and operations.
- Commercial: sellability, demonstration value, retention, pricing/delivery cost and sales friction when materially relevant.
- User: task success, clarity, speed, cognitive load, accessibility and error recovery.
- Product: problem/value fit, priority, scope, measurable outcome and smallest useful version.
- Quality: regressions, failure modes, edge cases, tests, observability and supportability.
- Security: authentication, authorization, tenant/trust boundaries, secrets, input/output safety, data exposure and abuse cases.
- Design: information architecture, visual hierarchy, interaction cost, consistency, responsive behaviour, accessibility and complete UI states. Mandatory for meaningful user-facing changes.
- Simplifier: challenge YAGNI, speculative abstractions, premature infrastructure and scope that can be safely removed.

When the execution environment supports subagents or parallel delegation, use the contracts in `.agents/roles/` with the same neutral context and keep reviewers independent until consolidation. When delegation is unavailable, perform isolated passes using the same contracts and avoid anchoring later passes on earlier conclusions.

Use `.agents/skills/minarrolabs-review/SKILL.md` as the orchestration contract and `.agents/skills/product-design/SKILL.md` for user-facing work when repository skills are supported.

## Consolidation

Prefer one coherent recommendation over eight role-play essays. Surface blockers first, then important improvements and optional follow-ups.

Before implementation use `GO`, `MODIFY` or `DO NOT BUILD`. After implementation/review use `READY`, `READY WITH FOLLOW-UPS` or `CHANGES REQUIRED`.

Block only on concrete high-value risks such as authorization/tenant-boundary violations, data corruption/loss, materially incorrect behaviour, unsafe migrations, broken critical flows or missing critical validation. Product, commercial, architecture, design and simplification findings are advisory by default unless they reveal a concrete blocker.

When perspectives disagree, state the trade-off and prefer the option that maximizes user/product value for the least justified complexity.

## Design baseline

For meaningful UI work:

- start from the user's primary task and make the primary action obvious;
- preserve or improve coherent existing components and patterns;
- cover desktop/mobile or the real target device intentionally;
- provide useful empty, loading, validation, error, success and disabled states;
- use semantic HTML, keyboard-operable interactions, visible focus and sensible contrast;
- do not rely on colour alone or hover-only essential actions;
- prefer progressive disclosure and fewer clearer controls over dense administration UI;
- inspect rendered output and capture evidence when tooling permits.

Design quality is part of product quality; avoid gratuitous redesigns that do not solve a real problem.

## Simplicity and execution

- Implement the smallest solution that preserves meaningful value, correctness and security.
- Do not introduce buses, events, layers, plugins, generic abstractions or async infrastructure without demonstrated need.
- When implementation is requested, use the review to improve underspecified details rather than creating avoidable confirmation loops.
- Re-review the actual implementation before completion; intention is not evidence.
- Run the repository validation gate and do not claim completion with known failures or unverified critical paths.
