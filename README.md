# DOC

Utilisation : 
ActionMailer pour l’envoie de mail automatique
Redis et mysql pour la db et serveurs de cache
Resque pour file d’attente de travaux
Scaleway pour la plateforme d’hébergement
Kubernetes et Docker pour serveurs dédiés ou services de déploiement en continu


Comment on utilise l’environnement local : 
On a configuré le Dockerfile.dev et le docker-compose.yml avec les différents services utilisés (redis:alpine, mysql5.7, crispy-octo-worker, crispy-octo-app)
Ajout des variable d’environnement dans le .env pour :  
Envoie d’email
Redis
La database
