# Utilisez une image de base avec Ruby installé
FROM ruby:3.1.3

# Définissez le répertoire de travail à l'intérieur du conteneur
WORKDIR /app

# Copiez le fichier Gemfile et Gemfile.lock dans le conteneur
COPY Gemfile Gemfile.lock ./

# Installez les gems à l'aide de Bundler
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copiez le reste des fichiers de l'application dans le conteneur
COPY . .

# Exposez le port 3500 que va utiliser Resque
EXPOSE 3500
