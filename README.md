# Symfony Skeleton

[![CI](https://github.com/ToniMinarro/Symfony-Skeleton/actions/workflows/ci.yml/badge.svg)](https://github.com/ToniMinarro/Symfony-Skeleton/actions/workflows/ci.yml)

Reusable Symfony baseline by Minarro Labs.

## Baseline

- PHP 8.4
- Symfony 7.4
- PostgreSQL 16
- Doctrine DBAL/ORM + migrations
- Symfony Security and Twig
- AssetMapper + Symfony UX Turbo
- PHPUnit 11
- PHPStan 2 at maximum level
- PHP CS Fixer
- Docker Compose with PHP-FPM and nginx

## Start

Requirements: Docker with the Compose plugin and GNU Make.

```bash
make init
```

The web container listens at <http://localhost:8080>. Use
<http://localhost:8080/health> as the minimal runtime smoke check.

## Quality gate

```bash
make test
make analyse
make check-style
make validate
make fix-style
```

GitHub Actions builds the Docker stack, runs the complete quality gate and
performs the HTTP health check on pull requests and on every commit merged to
`main`.

## Engineering guides

- [Architecture](docs/architecture.md): default boundaries, dependency rules,
  persistence and frontend decisions.
- [Development](docs/development.md): delivery workflow, testing strategy,
  migrations, security and definition of done.
- [Base lifecycle](docs/base-management.md): Copier ownership, versioning and
  safe updates for consuming applications.

The development database is `app`; tests use the isolated `app_test`
database. Schema changes should be expressed as Doctrine migrations.

This repository intentionally contains no product domain. It is a starting
point for new Symfony applications and the versioned technical/architectural
base they can continue to update from; it is not a shared business framework.
