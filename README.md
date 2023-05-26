# README

# Step 1

Create a .env with the content of .env.dist at the root directory
then run the command bash commeand ```make dev```

# Step 2

Launch http://localhost:3000

# Step 3 

The app is now running you can test it by running :
```make tests```

# Step 4

You can also set back to development the env setup when you are done by doing :
```make env_res```


# Troubleshoot

If any error occurs, make sure to have both make and docker install by running ```make -v``` and ```docker -v```.

If you are getting a migration error after running ```make dev``` do the following :

```docker compose up -d --build```
then ```docker ps```to make sure the containers are properly running
followed by ```docker exec -t crispy-octo-app-1 bundle exec rails db:migrate```
and finally : ```docker exec -t crispy-octo-app-1 bundle exec rails db:fixtures:load```

