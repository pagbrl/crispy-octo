
dev:
	docker compose up -d --build
	@sleep 10
	docker exec -t crispy-octo-app-1 bundle exec rails db:migrate
	docker exec -t crispy-octo-app-1 bundle exec rails db:fixtures:load
#Pour faire les tests (retourne une erreur car y'a un test qui est fait pour retourner les erreurs)
tests:
	docker exec -t crispy-octo-app-1 bundle exec rails db:environment:set RAILS_ENV=test 
	docker exec -t crispy-octo-app-1 bundle exec rails test
# Après les tests refaire --make env_res pour reset l'environnement passer de test a dev
env_res:
	docker exec -t crispy-octo-app-1 bundle exec rails db:environment:set RAILS_ENV=development
	


	
