# Agent instructions

This repository is the reusable Symfony baseline for Minarro Labs projects.
Keep it generic: product-specific domain concepts, integrations, deployment
providers, and abstractions belong in the product that proves the need for them.

Before making structural changes, read `docs/architecture.md`,
`docs/development.md`, and `docs/ai-review.md` and follow them as sources of
truth.

## Default operating mode

The operator should be able to ask for a feature, fix, refactor, design change,
review, or business/product recommendation with a normal prompt. Do not require
them to invoke specialist roles manually.

For every meaningful request, silently run a proportionate Minarro Labs review
before and during the work. Use the perspectives below as independent lenses,
then consolidate them into one plan or verdict. Do not dump repetitive
role-play output unless disagreement or risk is useful to the operator.

### Required perspectives

- **Technical:** architecture, maintainability, performance, domain boundaries,
  framework fit, migration and operational impact.
- **Commercial:** ability to sell, demonstrate value, reduce delivery cost,
  improve retention, support pricing, or remove sales friction. Do not force a
  commercial angle onto purely internal maintenance work.
- **User:** clarity, speed, cognitive load, accessibility, error recovery and
  whether the real user problem is improved.
- **Product:** problem/value fit, priority, scope, measurable outcome and whether
  a smaller experiment could validate the need first.
- **Quality:** failure modes, regressions, edge cases, test strategy,
  observability and supportability.
- **Security:** trust boundaries, authorization, tenant isolation, secrets,
  injection, data exposure, abuse cases and dependency/configuration risk.
- **Design:** visual hierarchy, interaction design, consistency, responsive
  behaviour, accessibility, empty/loading/error states and perceived quality.
  This lens is mandatory for user-facing changes.
- **Simplifier:** actively challenge the work for YAGNI, speculative
  abstractions, premature infrastructure and scope that can be safely removed.

Use `.agents/skills/minarrolabs-review/SKILL.md` as the reusable orchestration
contract and `.agents/skills/product-design/SKILL.md` for user-facing work when
the execution environment supports repository skills. Even when it does not,
follow the same rules from this file.

### Consolidation rules

- Prefer one coherent recommendation over eight independent essays.
- Surface **blockers** first: security boundary violations, data-loss risk,
  broken tenant isolation, correctness regressions, missing critical validation,
  or requirements that make the proposed approach unsafe.
- Treat product, commercial, design, architecture and simplification findings as
  **advisory** by default unless they reveal a concrete blocker.
- When perspectives disagree, state the trade-off and choose the option that
  maximizes user/product value for the least justified complexity.
- Scale review depth to risk. A copy tweak needs a lightweight pass; auth,
  payments, tenancy, migrations and destructive operations need a deep pass.
- Never manufacture concerns just to make every perspective produce output.

## Working rules

- Keep each change focused on one objective and avoid speculative architecture.
- Grow product code by business capability and vertical slice only when real use
  cases require those boundaries; do not create empty layers in advance.
- Prefer synchronous Symfony application flows until asynchronous delivery is a
  demonstrated requirement.
- Keep controllers thin, use constructor injection, and keep domain rules away
  from framework and persistence concerns where practical.
- Define database changes exclusively through versioned Doctrine migrations.
- Add or update tests at the lowest useful level for every behaviour change or
  bug fix.
- Update the relevant documentation in the same change when architecture,
  workflow, configuration, or operational behaviour changes.
- Use Conventional Commits for commit messages.
- Never commit production credentials, reusable default passwords, secrets, or
  personal demo data.

## User-facing design baseline

For any UI change, improve the product surface rather than merely making it
functional:

- Start from the user's primary task and make the main action visually obvious.
- Preserve or strengthen a coherent design system; avoid isolated one-off UI.
- Cover desktop and mobile layouts intentionally.
- Provide useful empty, loading, success, validation and failure states.
- Use semantic HTML, keyboard-operable interactions, visible focus and sensible
  contrast; do not rely on colour alone to communicate state.
- Prefer fewer, clearer controls and progressive disclosure over dense admin UI.
- Include screenshots or equivalent evidence for meaningful visual changes when
  the workflow allows it.

## Validation

Run `make validate` before considering a change complete. Do not report work as
finished with known failing checks. If a validation step cannot run, state the
exact blocker and what remains unverified.
