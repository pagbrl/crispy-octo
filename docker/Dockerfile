FROM ruby:3.1.3

RUN apt update && apt install -y \
  build-essential \
  nodejs \
  libsqlite3-dev \
  default-mysql-client \
  libxml2 \
  libxslt1-dev \
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