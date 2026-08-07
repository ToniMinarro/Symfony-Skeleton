# Agent instructions

This repository is the reusable Symfony baseline for Minarro Labs projects.
Keep it generic: product-specific domain concepts, integrations, deployment
providers, and abstractions belong in the product that proves the need for them.

Before making structural changes, read `docs/architecture.md` and
`docs/development.md` and follow them as the source of truth.

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

## Validation

Run `make validate` before considering a change complete. Do not report work as
finished with known failing checks. If a validation step cannot run, state the
exact blocker and what remains unverified.
