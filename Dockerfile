FROM ruby:3.1.3-alpine

# Installation des dépendances
RUN apk update

RUN apk add --no-cache build-base postgresql-dev nodejs yarn tzdata redis

# Définition du répertoire de travail
WORKDIR /app

# Installation des gems
COPY Gemfile Gemfile.lock /app/
RUN bundle install --jobs=4 --retry=3

# Copie du code source de l'application
COPY . /app/

# Configuration de l'environnement
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV DATABASE_URL=postgres://root@localhost:5432/crispy_octo_development
ENV REDIS_URL=redis://redis:6379/0
ENV RAILS_ENV=production
# Fixme
ENV EMAIL_FROM=null
ENV EMAIL_PORT=null
ENV EMAIL_USERNAME=null
ENV EMAIL_PASSWORD=null

# Précompilation des assets
RUN bundle exec rake assets:precompile

# Exécution de la migration de la base de données
RUN bundle exec rake db:migrate

# Exposition du port et lancement de l'application
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]