# Architecture guide

## Purpose

This repository starts deliberately close to the Symfony defaults. Product
code should grow into a modular monolith: one deployable application with
explicit boundaries that keep domain rules independent from delivery and
infrastructure concerns.

The architecture is a direction, not a requirement to create empty layers.
Add a boundary when a real use case needs it and choose the smallest design
that keeps the rule clear and testable.

## Default decisions

- Start with a modular monolith. Do not introduce microservices merely to
  mirror internal modules.
- Organise product code by business capability, not by technical type.
- Use pragmatic domain modelling for concepts with rules or invariants.
- Separate state-changing use cases from read-only use cases when that makes
  their contracts clearer. A message bus is optional, not a prerequisite.
- Keep Symfony, Doctrine and external integrations at the edges of the
  application where practical.
- Render web pages on the server with Twig. Use Turbo for navigation and
  partial updates, and Stimulus only for local browser behaviour.
- Prefer synchronous execution until an asynchronous requirement is proven.

## Vertical slices

Once the application has business concepts, new code should be grouped by
concept:

```text
src/
  Sale/
    Domain/
      Model/
      Service/
    Application/
      Create/
      Find/
    Infrastructure/
      Persistence/
    Entrypoint/
      Controller/
      Command/
  Identity/
    Domain/
    Application/
    Infrastructure/
    Entrypoint/
  Core/
  Shared/
tests/
  Sale/
  Identity/
```

Not every slice needs every directory. Create only the pieces used by the
current behaviour.

- `Domain/Model` contains entities, aggregates, value objects, enums and
  invariants.
- `Domain/Service` contains domain services and capability contracts such as
  repository interfaces.
- `Application/<Verb>` contains one use case and its input, handler and result.
- `Infrastructure` contains persistence and external-system adapters.
- `Entrypoint` contains HTTP controllers and Symfony Console commands.
- `Core` is reserved for shared concepts that have domain meaning.
- `Shared` is reserved for generic application or technical concerns; it must
  not become a miscellaneous business layer.

The initial `src/Controller` directory is suitable for the skeleton's health
endpoint. A product should migrate code incrementally into slices as real
concepts appear; a speculative, repository-wide restructuring is discouraged.

## Dependency direction

Dependencies point towards the domain:

```text
Entrypoint  ─┐
             ├──> Application ──> Domain
Infrastructure┘
```

- `Domain` depends only on domain code and PHP.
- `Application` coordinates domain models and contracts; it must not import
  concrete infrastructure adapters.
- `Infrastructure` implements capabilities required by inner layers.
- `Entrypoint` validates input, invokes a use case and translates its result to
  HTTP or console output. It does not own business rules or persistence flows.

Cross-slice dependencies must represent a genuine business relationship. Avoid
shortcut imports that expose another slice's persistence details.

## Application use cases

A state change should have an explicit command-like input and handler; a read
should have an explicit query-like input and handler when the distinction adds
value. Group both by intent (`CreateSale`, `FindSale`, `OpenCashSession`) rather
than in global `Command` and `Query` folders.

Inputs contain primitive transport data. Handlers coordinate domain behaviour
and capability contracts. Validation that protects a business invariant lives
in the domain; validation of request shape belongs at the entrypoint or use-case
boundary.

Use direct synchronous calls by default. Introduce Symfony Messenger, queues,
events or retries only for a concrete delivery or consistency requirement.

## Persistence

The database schema is defined exclusively through versioned Doctrine
migrations. Application startup and deployment apply pending migrations; code
must not mutate the schema implicitly.

Repository interfaces belong to the inner layer that needs the capability.
Concrete implementations belong under `Infrastructure/Persistence` and expose
methods with business intent rather than generic CRUD APIs.

A slice may use Doctrine ORM mapping on its domain entities when that is the
simplest maintainable option. ORM entities that rely on lazy proxies must not
be `final`. If persistence-independent domain objects are important, map and
reconstitute them in a DBAL or ORM adapter. Do not maintain two parallel models
without a demonstrated benefit.

Transaction boundaries belong around complete application use cases. Avoid
flushing halfway through a business operation unless the operation explicitly
requires that durability point.

## Identity and tenant boundaries

If the product is multi-tenant, every tenant-owned record carries its tenant
identifier and every repository read, write and delete constrains it.

Private HTTP flows derive the tenant from the authenticated identity; they do
not trust a tenant identifier supplied by the request. Repositories still
require the tenant identifier as defence in depth. Access to a resource owned
by another tenant should normally be indistinguishable from an unknown
resource.

Symfony Security owns authentication lifecycle, session fixation protection,
CSRF and password hashing. Passwords are stored only as adaptive hashes and
secrets never belong in migrations or committed production configuration.

## Web interface

Twig is the default presentation layer and keeps auto-escaping enabled.
Controllers provide data to templates rather than assembling HTML strings.
Extract partials or components only after repetition is visible.

Turbo Drive handles ordinary navigation, Turbo Frames isolate independently
updated fragments and Turbo Streams represent server-driven partial changes.
Stimulus controllers are small and local to behaviour that HTML and Turbo
cannot express. The server remains the source of truth; browser state must not
become a second business model.

AssetMapper and import maps are the default asset pipeline. Adding a bundler or
SPA requires a concrete limitation that the existing pipeline cannot meet.

## Operational boundaries

`/health` is a lightweight process-level smoke check and must not depend on the
database or an external provider. Deeper readiness checks, when needed, should
be separate and explicit.

Defer asynchronous messaging, shared-framework abstractions, generic
repositories, event sourcing and service extraction until a real consumer,
variation or scaling need exists.

## Evolving this guide

Architecture documentation changes in the same delivery as the structural
decision it describes. When a project intentionally departs from these
defaults, record the context, selected option, consequences and replacement or
rollback path in its own documentation.
