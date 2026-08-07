UID := $(shell id -u)
GID := $(shell id -g)
COMPOSE := docker compose
APP := app

.PHONY: init build start stop down erase composer-install migrate test-database test analyse check-style validate fix-style shell logs

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

composer-install:
	$(COMPOSE) exec -T -u $(UID):$(GID) -e COMPOSER_HOME=/tmp/composer $(APP) composer install --no-interaction

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

shell:
	$(COMPOSE) exec -u $(UID):$(GID) $(APP) sh

logs:
	$(COMPOSE) logs -f $(APP)
