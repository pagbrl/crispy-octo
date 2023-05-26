# INFO  
![alt text](https://i.ibb.co/0sW0q2V/membre.png "Titre de l'image")

# README 

This README documents the necessary steps to set up the application.

## Ruby version 

* Ruby 3.1.3

## System dependencies

* mysql-client
* git

## Configuration

* Update the .env file with your configuration 

## Database creation 

* A MariaDB database is created when the docker-compose file is launched.

## Database initialization

* The database is initialized when the Rails app is launched for the first time.

## How to run  

* Clone the repository
* Go to the project folder
* Run "docker-compose up -d" to build and launch the containers 
* The Rails app will be running on port 8081

## Services

* MariaDB (database) 
* Redis (cache)

## Deployment instructions

* The app is meant to be deployed with Docker.

## Dockerfile 

The Dockerfile creates the image and installs the dependencies.
It copies the files from the host, installs the gems with bundle install and exposes port 3000.

## Docker-compose

The docker-compose file creates the necessary services (database, cache, workers) to run the Rails app. 
It links the containers, maps the ports and volumes.

* The crispy-ruby service is the main Rails app
* The crispy-resque service runs the background jobs
* The crispy-mariadb service is the MariaDB database 
* The crispy-redis service is the Redis cache
