# Documentation de déploiement - crispy-octo

Cette documentation fournit les instructions nécessaires pour déployer le projet "crispy-octo" à l'aide de Kubernetes. Assurez-vous de suivre les étapes ci-dessous dans l'ordre indiqué pour déployer le projet avec succès.


## Prérequis:

Avant de commencer le déploiement, assurez-vous de disposer des éléments suivants :

- Un serveur Redis
- Un serveur MySQL
- Un cluster Kubernetes


## Récupération du référentiel:

Clonez le référentiel en utilisant la commande suivante :

`git clone -b florent https&#x3A;//github.com/DelvLoping/crispy-octo.git`


## Configuration de kubectl:

Assurez-vous d'avoir kubectl installé sur votre machine. Si ce n'est pas le cas, veuillez vous référer à la documentation officielle pour l'installer.

Téléchargez le fichier de configuration kubeconfig à partir de votre hébergement cloud et définissez la variable d'environnement KUBECONFIG pour pointer vers le chemin de votre fichier kubeconfig :

`export KUBECONFIG=/chemin/vers/mon-kubeconfig`


## Déploiement des configurations:

Dans le répertoire du projet, appliquez les configurations de déploiement en exécutant les commandes suivantes :

`kubectl apply -f deployment.yaml kubectl apply -f deploymentworker.yaml kubectl apply -f ingress.yaml kubectl apply -f service.yaml`


## Configuration des variables d'environnement:


## Configurez les variables d'environnement dans un secret Kubernetes en exécutant la commande suivante :

`kubectl create secret generic crispy-octo-secret \\ --from-literal=DATABASE_URL=VOTRE_DATABASE_URL \\ --from-literal=EMAIL_FROM=VOTRE_EMAIL \\ --from-literal=EMAIL_USERNAME=VOTRE_API_KEY \\ --from-literal=REDIS_URL=VOTRE_REDIS_URL \\ --from-literal=EMAIL_PASSWORD=VOTRE_EMAIL_PASSWORD`

Remplacez les valeurs VOTRE_DATABASE_URL, VOTRE_EMAIL, VOTRE_API_KEY, VOTRE_REDIS_URL et VOTRE_EMAIL_PASSWORD par les valeurs appropriées.


## Initialisation de la base de données MySQL:


## Obtenez les identifiants des pods en exécutant la commande suivante :

`kubectl get pods`

Copiez le nom du pod contenant l'application et exécutez la commande suivante pour accéder à un terminal interactif :

`kubectl exec -it &lt;nom_du_pod> --container=crispy-octo-ruby -- /bin/sh`

Dans le terminal interactif, exécutez les commandes suivantes pour initialiser la base de données :

`rake db:create rake db:migrate`

Une fois ces étapes terminées, votre projet "crispy-octo" sera déployé avec succès sur votre cluster Kubernetes.
