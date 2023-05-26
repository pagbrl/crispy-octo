
Documentation de l'application

    Introduction

    Cette documentation fournit des instructions pour l'installation, la configuration et le déploiement de l'application.

    Version de Ruby

    Ruby 3.1.3-alpine3.17

    Dépendances système

    Rails 7.0.4
    Puma 5.0
    Redis 4.0
    MySQL
    Resque

    Configuration de l’environnement de développement

    Pour exécuter votre application Ruby avec Docker, vous devez configurer certaines variables d'environnement dans le fichier docker-compose.yml. Voici les configurations à prendre en compte :

	    Fichier dockerFile :

            Installation des dépendances : 
            Ce fichier contient les installations des dépendances, permettant d’offrir un environnement complet et fonctionnel pour exécuter l’application sur n’importe quelle machine dans un conteneur Docker. 

            Installation de Bundler et Rails : 
            Bundler (gestionnaire de dépendances Ruby) et Rails (framework de développement d’applications web Ruby) sont essentiels pour l’exécution. 

            Configuration du répertoire de travail et copie des fichiers: 
            Le répertoire de travail est défini par l’instruction WORKDIR. 
            Les fichiers de l’application sont copiés dans ce répertoire grâce à l’instruction COPY (code source de l’app, Gemfile et Gemfile.lock). 

            Installation des gems et du gem sendgrid-ruby : 
            L’exécution de la commande ‘bundle install” est nécessaire pour installer les gems de l’application compris dans le fichier Gemfile.lock. Il est également nécessaire d’installer le gem “sendgrid-ruby” pour faciliter l’envoi des courriers électroniques depuis l’application. 

            Configuration des variables d’environnement : 
            Le fichier “.env .dist” est copié en tant que “.env”  via l’instruction RUN cp .env .dist .env” pour fournir une configuration initiale des variables d’environnement.

			

        Fichier docker-compose.yml:

		    Architecture basée sur plusieurs conteneurs : 
            L’application utilise plusieurs conteneurs interconnectés : 
            1/ Service “app” : ce conteneur exécute l’application Ruby on Rails. Il est lié aux deux autres conteneurs pour permettre une bonne communication. 
            2/ Service “db” : ce conteneur utilise l’image Docker de MySQL 5.7 pour fournir une bdd MySQL. Il est connecté à l’application Rails. 
            3/ Service “redis” : ce conteneur utilise l’image Redis pour la gestion du cache et d’autres fonctionnalités nécessitant un stockage rapide des données. 
            4/ Service “worker”: ce conteneur exécute des tâches en arrière-plan de l’application (utilise Resque (cf plus bas)). 
            Chaque conteneur est configuré avec des variables d’environnement spécifiques, des liens vers d’autres services et des volumes docker pour que l’application fonctionne de manière fluide; 


		    Les variables d’environnement : 
            Les variables d’environnement doivent figurer dans le docker-compose.yml mais également dans un fichier .env pour les informations sensibles et pour faciliter les mises à jour des configurations. 
		    L'application utilise les variables d'environnement suivantes pour la configuration :
            RAILS_NEW : L’environnement Rails pour l’exécution de l’application 
            APP_SECRET : La clé secrète utilisée par l’application Rails pour le chiffrement des cookies et d’autres fonctionnalités de sécurité. Générez une clé aléatoire et sécurisée. 
            DATABASE_URL: L’URL de connexion à la base de données MySQL.
            REDIS_URL: L’URL de connexion à Redis.
            EMAIL_PORT: Le port utilisé pour les services d’envoi de courriers electroniques 
            EMAIL_USERNAME: Le nom d’utilisateur pour l’authentification auprès du service d’envoi de courriers électroniques 
            EMAIL_FORM: l’adresse mail de l’expéditeur par défaut pour les courriers électroniques envoyés par l’application 
            EMAIL_PASSWORD: mot de passe pour l’authentification auprès du service d’envoi de courriers électroniques, est également la clé API du service


        Fichier git ignore:

        On y met par exemple le .env, pour que les variables d’environnement ne soient pas accessibles sur le repo github. Le ._mysql_data_dir aussi doit y être puisqu’il est généré au lancement des conteneur docker.
	
        La base de données MySQL

            Création et initialisation :
            1/ Exécuter l’environnement Docker
            docker-compose up -d 
            2/ Dans le terminal du service App sur docker exécuter cette commande qui créer la bdd et exécute les migrations : 
		    bin/rails db:create db:migrate
            3/ Dans le terminal du service App sur docker, exécuter cette commande qui charge les fixtures écrites dans le code (les articles) : 
            bin/rails db:fixtures:load

    Gestion des encodages 
        
        Il est possible de rencontrer des problèmes d’encodage lors du chargement des fixtures de la bdd.
        1/ Dans le service db dans docker-compose.yml, ajouter la ligne qui spécifie  l’encodage : 
        command: mysqld --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
        2/ Arrêter les containers avec docker compose down
        3/ Supprimer le dossier ._mysql_data_dir
        4/ Mettre à jour les container avec la commande de build
        ​​docker build -t crispy-octo -f Dockerfile.dev ./
        5/ Relancer les containers avec docker compose up 

		
    Services (queues de tâches, serveurs de cache, moteurs de recherche etc..) 
        Queue de tâches
        L'application utilise Resque pour la gestion des tâches asynchrones  en arrière-plan (envoi de mails ou exécution de tâches longues) 

        Configuration de Resque
        1/ Vérifier la présence de la dépendance Resque dans Gemfile “gem ‘resque’”
        2/ Créer un fichier ‘resque.rb’ dans le répertoire ‘config/initializers’
        3/ Ajouter le code suivant pour configurer Resque : 
        require 'resque'

        Resque.redis = ENV.fetch("REDIS_URL")
        4/ Personnaliser les variables d’environnement 
        Dans le docker-composer.yml, la variable d’environnement REDIS_URL sert à stocker les tâches en attente et les résultats des travaux exécutés


        Cela permet à Resque d’utiliser l’URL de connexion Redis spécifiée dans la variable d’environnement ‘REDIS_URL’ configurée précédemment. 

        Lancement des travailleurs Resque
        Il faut lancer une commande pour lancer les travailleurs Resque pour traiter les tâches en arrière-plan de l’application : 
        bundle exec rake environment resque:work QUEUE=*

        Serveur de cache (Redis)
        L'application utilise Redis comme serveur de cache pour stocker temporairement des données et améliorer les performances globales. On l’utilise grâce à la création du service Redis dans docker-compose.yml.

        Base de données (MySQL)
        L'application utilise MySQL comme système de gestion de base de données. 
        Configuration 

        Gestion des migrations 

    Instructions de déploiement

    Vérification de la compatibilité de l’image avec la production 
    Il est important de vérifier si l’image Docker répond aux exigences de sécurité; Nous avons choisi de nous aider de Triny en local pour faciliter ces vérifications. 
    1/ Limitation des privilèges dans le DockerFile
    On va créer un nouvel utilisateur et le passer en non root de façon à réduire les droits de l’utilisateur. 
    RUN adduser -D -u 8877 don
    # Change to non-root privilege
    USER don

        Création d’un conteneur registry 
        Pour faciliter le déploiement et le partage de l’application, il est essentiel de créer un conteneur registry via Docker Hub.
        1/Création d’un repository sur Docker Hub   
	    Cammmi/getting-started
        2/ Connexion à Docker Hub 
        docker login
        3/ Identification de l’image 
        docker tag 5f1d970ebfac cammmi/getting-started 
        4/ Push de l’image vers Docker Hub
        docker push cammmi/getting-started 
        5/ Vérification de la publication de l’image
        docker run -dp 3000:3000 cammmi/getting-started 

Création des manifestes Kubernetes 

        Configuration du SMTP avec SendGrid 
        Pour envoyer des mails depuis l’application, on utilise SendGrid car c’est une solution connue gérer l’envoi de mails en masse. SendGrid propose un service fiable qui minimise le risque de blocage de mail et les filtres anti-spam. De plus, c’est une solution facile à intégrer en Ruby grâce à une documentation complète accessible sur le lien suivant : https://docs.sendgrid.com/for-developers/sending-email/v3-ruby-code-example. SendGrid propose également des fonctionnalités avancées permettant de personnaliser des mails et leur suivi grâce à des variables dynamiques (suivre les statistiques d’envoi, les clics, le désabonnement etc..). 


        Configuration sur SendGrid
        1/ Création d’un compte SendGrid
        2/ Création d’un sender 
	    Le sender correspond à l’adresse mail à partir duquel les mails seront envoyés 
        3/ Création d’une clé API

        Intégration dans l’application
        1/ Ajout de  gem 'actionmailer' dans le Gemfile pour permettre l’envoi des mails
        2/ Ajout de RUN gem install sendgrid-ruby dans le DockerFile (puis reconstruire l’image comme après chaque modification)
        3/ Ajout des variables d’environnement liés à l’envoi des mails 
        EMAIL_FROM = mail fourni dans SendGrid
	    EMAIL_PASSWORD= clé API fournie par SendGrid

        Grâce à ces configurations, les suscribers de l’application reçoivent des mails de la part de l’administrateur (le sender) lorsqu’ils souscrivent. 


        Déploiement d’un ingress controller (Nginx) 

        Hébergement

        Pour déployer l’application nous avons choisi l'hébergement sur Scaleway après l’avoir comparé avec AWS, DigitalOcean et OVH, pour plusieurs raisons : 
        Prix bas 
        Facilité d’utilisation 
        Fiabilité 
        Scalabilité suffisante pour l’application 


