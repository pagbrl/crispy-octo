bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:fixtures:load

bundle exec rails -it server -b 0.0.0.0
