UID := $(shell id -u)
GID := $(shell id -g)
COMPOSE_FILE := $(firstword $(wildcard compose.yaml docker-compose.yml))
COMPOSE := docker compose $(if $(COMPOSE_FILE),-f $(COMPOSE_FILE),)
APP ?= app
COPIER ?= copier

-include Makefile.app

.PHONY: init build start stop down erase ps composer-install composer console migrate test-database test analyse check-style validate fix-style base-sync base-update base-version shell bash logs

init: build start composer-install migrate

build:
	$(COMPOSE) build

start:
	$(COMPOSE) up -d --wait

stop:
	$(COMPOSE) stop

down:
	$(COMPOSE) down --remove-orphans

erase:
	$(COMPOSE) down -v --remove-orphans

ps:
	$(COMPOSE) ps

composer-install:
	$(COMPOSE) exec -T -u $(UID):$(GID) -e COMPOSER_HOME=/tmp/composer $(APP) composer install --no-interaction

composer:
	$(COMPOSE) exec -T -u $(UID):$(GID) -e COMPOSER_HOME=/tmp/composer $(APP) composer $(CMD)

console:
	$(COMPOSE) exec -T $(APP) php bin/console $(CMD)

migrate:
	$(COMPOSE) exec -T $(APP) php bin/console doctrine:migrations:migrate --no-interaction --allow-no-migration

test-database:
	$(COMPOSE) exec -T $(APP) php bin/console doctrine:database:create --env=test --if-not-exists
	$(COMPOSE) exec -T $(APP) php bin/console doctrine:migrations:migrate --env=test --no-interaction --allow-no-migration
	$(COMPOSE) exec -T $(APP) php bin/console doctrine:migrations:up-to-date --env=test

test: test-database
	$(COMPOSE) exec -T $(APP) php vendor/bin/phpunit

analyse:
	$(COMPOSE) exec -T $(APP) php vendor/bin/phpstan analyse --memory-limit=512M

check-style:
	$(COMPOSE) exec -T $(APP) php vendor/bin/php-cs-fixer fix --dry-run --diff

validate:
	$(COMPOSE) exec -T -u $(UID):$(GID) -e COMPOSER_HOME=/tmp/composer $(APP) composer validate --strict
	$(COMPOSE) exec -T $(APP) php bin/console lint:container
	$(COMPOSE) exec -T $(APP) php bin/console lint:twig templates
	$(COMPOSE) exec -T $(APP) php bin/console lint:yaml config
	$(COMPOSE) exec -T $(APP) php bin/console doctrine:schema:validate --skip-sync
	$(COMPOSE) exec -T $(APP) php bin/console debug:asset-map
	$(MAKE) test
	$(MAKE) analyse
	$(MAKE) check-style

fix-style:
	$(COMPOSE) exec -T $(APP) php vendor/bin/php-cs-fixer fix

base-sync:
	$(COMPOSE) exec -T $(APP) php tools/base-sync.php
	$(COMPOSE) exec -T $(APP) chown -R $(UID):$(GID) /app/vendor
	@packages="$$( $(COMPOSE) exec -T $(APP) php tools/base-sync.php --packages )"; \
		$(COMPOSE) exec -T -u $(UID):$(GID) -e COMPOSER_HOME=/tmp/composer $(APP) composer update $$packages --with-all-dependencies --no-interaction --prefer-dist --no-progress

base-update:
	@command -v $(COPIER) >/dev/null 2>&1 || { echo "Copier >=9.17 is required. Install it with: pipx install copier  (or: uv tool install copier)"; exit 1; }
	@test -f .symfony-skeleton.yml || { echo "This project is not yet linked to Symfony-Skeleton."; exit 1; }
	$(COPIER) update --answers-file .symfony-skeleton.yml --defaults --trust
	$(MAKE) build
	$(MAKE) start
	$(MAKE) base-sync
	$(MAKE) validate

base-version:
	@cat .symfony-skeleton-version

shell:
	$(COMPOSE) exec -u $(UID):$(GID) $(APP) sh

bash: shell

logs:
	$(COMPOSE) logs -f $(APP)
