# Utilisez une image de base avec Ruby installé
FROM ruby:3.1.3

# Copiez le fichier Gemfile et Gemfile.lock dans le conteneur
COPY Gemfile Gemfile.lock ./

# Définissez le répertoire de travail à l'intérieur du conteneur
WORKDIR /app

# Installez les gems à l'aide de Bundler
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copiez le reste des fichiers de l'application dans le conteneur
COPY . .

# Exposez le port 3500 que va utiliser Resque
EXPOSE 3500

CMD ["bundle", "exec", "rails", "db:create"]
CMD ["bundle", "exec", "rails", "db:migrate"]
CMD ["bundle", "exec", "rails", "db:fixtures:load"]

CMD ["bundle", "exec", "rails", "-it", "server", "-b", "0.0.0.0"]