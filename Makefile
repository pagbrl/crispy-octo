
dev:
	docker-compose up -d --build
	@sleep 5
	docker exec -t crispy-octo-app-1 bundle exec rails db:migrate
	
