FROM ruby:3.1.3-alpine

RUN apk update && apk add --no-cache \
  build-base \
  nodejs \
  tzdata \
  sqlite-dev \
  mysql-dev \
  mysql-client \
  libc-dev \
  libxml2-dev \
  libxslt-dev \
  yarn \
  git

WORKDIR /var/www/

# Copier les fichiers du projet dans le conteneur
COPY ./Gemfile ./Gemfile.lock ./
# Installation des gems
RUN gem install bundler:2.3.5 && bundle install --jobs 20 --retry 5

# Copier le reste des fichiers du projet dans le conteneur
COPY . .

# Exposer le port 3000 pour l'application Rails
EXPOSE 3000

# Lancer le serveur Rails en tant que commande par défaut
CMD ["rails", "server", "-b", "0.0.0.0"]