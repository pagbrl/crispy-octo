# DOC Crispy-octo Groupe 7

<h3>Utilisation de  l’environnement en local : </h3>

On a configuré le Dockerfile.dev et le docker-compose.yml avec les différents services utilisés (redis:alpine, mysql5.7, crispy-octo-worker, crispy-octo-app)<br>
Ajout des variable d’environnement dans le .env pour :  
- Envoie d’email
- Redis
- La database
Tests pour le chargement des  articles et des subscribers <br>
Vérification de l'envoie d'email à l'inscription

<h3>Utilisation de  l’environnement en prod : </h3>

Push les images précédemment construites sur scaleway<br>
Création d'un cluster Kubernetes<br>
Création d'une Database MYSQL et Redis<br>
Création des manifests Kubernetes (crispy-octo-app-deployment.yaml, crispy-octo-app-service.yaml, worker.yaml)<br>
Données en dur passées en secret par la base64 (secret.yaml)

<h3>Technical Document Design :</h3>

Composant ActionMailer
- Le composant ActionMailer est utilisé pour l'envoi de mails automatiques tels que les newsletters. Il est intégré dans les contrôleurs pour faciliter l'envoi de mails aux abonnés.

Composants Redis et MySQL
- Redis est utilisé comme serveur de cache pour améliorer les performances en stockant temporairement les données fréquemment utilisées. MySQL est utilisé comme base de données principale pour stocker les données de l'application.

Mysql est fiable et robuste. Il est optimisé pour offrir de bonnes performances pour les charges de travail typiques des applications web. Il prend en charge des requêtes rapides, l'indexation efficace des données. De plus, il est très populaire.

Redis va nous permettre de gérer d'intégrer facilement des fonctionnalités asynchrones. Redis est une base de données en mémoire qui offre des performances exceptionnelles en raison de sa capacité à stocker les données en RAM

Composant Resque
-  Resque est utilisé pour la gestion de file d'attente de travaux. Il permet de traiter les tâches en arrière-plan, telles que l'envoi de mails, afin de ne pas retarder les réponses aux requêtes des utilisateurs.

Composants Kubernetes et Docker
- L'application est déployée sur des serveurs dédiés ou utilisant des services de déploiement en continu basés sur Kubernetes et Docker. Ces technologies permettent une gestion efficace des conteneurs pour garantir la disponibilité et la scalabilité de l'application

Composant Scaleway
- Scaleway est connu pour proposer des tarifs compétitifs. Scaleway offre une interface conviviale et intuitive, ce qui facilite la gestion de vos ressources cloud et le déploiement de vos conteneurs Docker.

Scaleway dispose de centres de données situés dans différentes régions européennes






