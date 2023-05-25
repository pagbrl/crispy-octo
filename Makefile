
dev:
	docker compose up -d --build
	@sleep 10
	docker exec -t crispy-octo-app-1 bundle exec rails db:migrate
	docker exec -t crispy-octo-app-1 bundle exec rails db:fixtures:load
	
