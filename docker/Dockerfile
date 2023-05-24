# Utiliser une image de base contenant Ruby 3.1.3 et MySQL
FROM ruby:3.1.3

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le Gemfile et le Gemfile.lock dans le conteneur
COPY Gemfile Gemfile.lock ./

# Installer la version spécifique de Bundler (2.4.3)
RUN gem install bundler:2.4.3

# Installer les dépendances
RUN bundle install

# Copier le reste des fichiers de l'application dans le conteneur
COPY . .

# Exécuter la commande pour démarrer l'application
CMD ["rails", "server", "-b", "0.0.0.0"]
