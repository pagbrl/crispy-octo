FROM ruby:3.1.3

# RUN apk update && apk add --no-cache \
#   build-base \
#   mysql-client \
#   git

RUN apt-get update

WORKDIR /var/www/

# Copier les fichiers du projet dans le conteneur
COPY ./Gemfile ./Gemfile.lock ./
# Installation des gems
RUN bundle install

# Copier le reste des fichiers du projet dans le conteneur
COPY . .

# Exposer le port 3000 pour l'application Rails
EXPOSE 3000

# Lancer le serveur Rails en tant que commande par défaut
CMD ["rails", "server", "-b", "0.0.0.0"]
