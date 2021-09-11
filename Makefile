.PHONY: up
up:
	docker-compose up -d

.PHONY: down
down:
	docker-compose stop

.PHONY: lint
lint:
	bundle exec rubocop -a
