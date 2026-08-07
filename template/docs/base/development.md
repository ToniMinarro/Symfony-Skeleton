# Development guide

## Working agreement

Keep each change focused on one objective with explicit acceptance criteria.
For collaborative repositories, associate work with an issue, use a descriptive
branch name and explain the validation performed in the pull request.

Use Conventional Commits. Typical prefixes are `feat`, `fix`, `refactor`,
`test`, `docs`, `build` and `chore`. Independent scope discovered during a
change should be tracked separately instead of being added silently.

Do not overengineer. Introduce an interface, event, bus, layer or shared
abstraction only when it protects a real boundary or has a known consumer.

## Local workflow

Requirements are Docker with Compose v2 and GNU Make. PHP, Composer, PostgreSQL
and the web server run inside containers.

```bash
make init       # build, start, install dependencies and migrate
make start      # start existing containers
make stop       # stop services without removing data
make logs       # follow PHP container logs
make shell      # open an application shell
make migrate    # apply pending migrations
make test       # prepare the isolated test database and run PHPUnit
make analyse    # run PHPStan at maximum level
make validate   # run the complete local quality gate
make fix-style  # apply the PHP coding standard
```

`make erase` removes containers and the database volume. It is destructive and
must always be an explicit choice.

The application runs at <http://localhost:8080>; `/health` is the minimal HTTP
smoke check. The development database is `app` and tests use `app_test`.

## Definition of done

A change is complete when:

1. The requested behaviour and relevant error paths are implemented.
2. A test at the lowest useful level protects new or corrected behaviour.
3. Migrations and configuration support both a clean installation and an
   upgrade from the previous state.
4. Relevant Markdown documentation changes with the code.
5. `make validate` succeeds.
6. A runtime-facing change receives an HTTP or console smoke test.

Do not declare success with known failing validation. If a check cannot run,
record the exact reason and the remaining verification.

## Test strategy

Choose the lowest layer that provides confidence:

- Unit tests protect domain invariants and pure behaviour.
- Architecture tests protect namespace placement and inward dependency rules
  once product slices exist.
- Integration tests protect mappings, repository queries, transactions and
  tenant isolation.
- Functional tests protect security, routes, HTTP responses, rendered HTML and
  Turbo contracts.
- Real-browser tests are reserved for JavaScript or browser behaviour that
  BrowserKit cannot demonstrate.

A bug fix includes a regression test that fails before the correction. A new
use case covers its main path and meaningful business failures. Avoid assertions
against implementation details when an observable contract is available.

Tests must be deterministic and isolated. They must not depend on execution
order, production data, wall-clock timing or external network availability.

## Database changes

Every schema change is a versioned migration. Migrations should be reviewable,
safe to apply once and compatible with the application version being deployed.
The empty skeleton intentionally permits `--allow-no-migration`.

Before merging a schema change, verify:

- installation from an empty volume;
- migration from the previous schema when applicable;
- preservation or explicit transformation of existing data;
- indexes and constraints that enforce important invariants;
- rollback or recovery expectations for destructive transformations.

Seed or demo loaders must be explicit and idempotent. Migrations never create a
user with a known password or insert environment-specific secrets.

## PHP and Symfony conventions

- Use `declare(strict_types=1)` in application PHP files.
- Prefer `final` for services and value objects that are not designed for
  extension. Doctrine ORM entities using lazy proxies are the exception.
- Keep controllers thin: validate transport input, invoke one use case and
  translate the result.
- Prefer constructor injection and autowiring. Avoid fetching services from the
  container at runtime.
- Use domain-specific exceptions or results for expected failures; do not use
  exceptions to hide ordinary branching.
- Keep environment-specific values in environment variables and validate
  required production configuration at startup.

Run PHP CS Fixer instead of manually formatting around its rules. PHPStan is
configured at its maximum level; suppressions require a narrow explanation and
must not conceal a type that can be modelled correctly.

## Frontend conventions

`assets/app.js` is the browser entrypoint. It starts Stimulus, loads styles and
enables Turbo through the import map. The base Twig template must retain
`{{ importmap('app') }}`.

Prefer server-rendered HTML and progressive enhancement. Use:

- ordinary links and forms for baseline behaviour;
- Turbo Drive for navigation;
- Turbo Frames or Streams for partial server-rendered updates;
- a local Stimulus controller for browser-only interaction.

Avoid global JavaScript state and duplicate client-side domain logic. Capture
values needed from a DOM event before the first asynchronous boundary. State-
changing actions use the appropriate HTTP method and CSRF protection; logout is
never a `GET` link.

Add JavaScript packages through AssetMapper/import maps unless a documented
requirement justifies a bundler. Update the lock/import-map files and run the
full quality gate after changing frontend dependencies.

## Security defaults

- Deny access by default and expose public routes explicitly.
- Use Symfony password hashers, CSRF protection and session handling.
- Apply rate limiting to authentication and abuse-prone public endpoints.
- Validate authorisation at the operation boundary, not only in navigation.
- Disable or archive records when audit history requires retention; reserve
  hard deletion for an explicit policy.
- Never commit production credentials, personal demo data or a reusable default
  password.

For multi-tenant products, add integration and functional tests proving that
one tenant cannot read, list, mutate or infer another tenant's resources.

## Documentation policy

Documentation is part of the change, not a later cleanup:

- `README.md` is the source of truth for purpose and quick start.
- `docs/architecture.md` records structural boundaries and decisions.
- `docs/development.md` records the development, validation and operational
  workflow.
- Feature-specific details live beside the concept or in a focused document.

Update or remove stale documentation in the same delivery. Prefer one source of
truth over duplicated instructions.

## Release gate

For a deployable increment:

1. Start from clean dependencies and, periodically, empty Docker volumes.
2. Install from `composer.lock` and apply all migrations.
3. Run `make validate`.
4. Exercise `/health` and the principal changed flow.
5. Verify production secrets, database version, trusted proxy/session settings
   and asset compilation for the target platform.
6. Record the deployed commit and perform a short post-deploy smoke test.

Backups, rollback and recovery procedures must be documented before storing
real user or business data.
