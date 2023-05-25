# Technical Design Document
 Group 1 : Romain Feregotto, Aziz Kone, Habib Hadjar, Yahya Adlouni, Loris Dié, Grégoire Richard


## Useful links and introduction : 

### links :
First of all you can find the link of the github [here](https://github.com/GregoireARichard/crispy-octo) 
And the link of the production deployment in here : 
[add link]
Technical documentation : 
[add link]
### Introduction : 
This document is meant to be representing our work and to present it in the clearest way possible and thus give a clear overview of the project.

We will be summarizing our work in the following way : 
First of all we will show the challenges we faced, namely the ones concerning the code that was given to us and the deployment itself in order for the readers to have all the information to understand the technical decisions that were taken.
Then, we will detail our technical choices.
## Technical issues faced: 
Although the repository was shown as ready for production we had to face few issues : 

 - Neither Dockerfile nor Docker-compose file were present.
 - The Docker alpine image was not working on MacOs
 - No .env was present
 - The production code still had some issues concerning the scalability
 - Neither redis environment nor declarations of any sort (including resque)
 - K8s just by existing
## Technical choices : 
In order for the readers to have a more understandable overview of our technical choices we will divide it in this chapter.
#### Docker related solutions
As stated earlier : No docker related files were present in the repository.
In order to fix that we of course built a Dockerfile and a Docker-compose.yml. Though as stated earlier we had an issue with Alpine 3.1.~ versions as the containers would keep crashing no matter everything we tried. To solve the situation we simply used ```ruby:3.1.3``` 
For the rest of the Dockerfile we chose to simply use bundle install and do this way : 
```Dockerfile
FROM ruby:3.1.3

WORKDIR /var/www

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
```
As opposed to precendently where we tried to import the dependencies with APK
##### the .env situation
concerning the .env : there was none. 
Hence we had to write one and deduct from all the dependencies, the one we needed but we also had to remove some _hardcoded_ values such as in ```app/mailer/suscriber_mailer.rb``` where a localhost value was written as such : 
```ruby
def welcome_email
    @url = "127.0.0.1" 
```
That we had to of course replace by : 
```ruby
def welcome_email
    @url = "#{ENV.fetch('WEBSITE_HOST')}"
```
Apart from that the .env includes (but not limited to) the following values : the RAILS_ENV, the MARIADB_HOST, DATABASE, USER, PASSWORD, URL, REDIS_URL, the WEBSITE_HOST and EMAIL_FROM for sendgrid. 

#### Repository related solutions
Although being "production ready" the repository had several few thing that had to be fixed.
First of all there was a scalability issue in ```app/models/article.rb``` where we had a code that would stock all the subscribers and then send an email which could have been a huge issue when the platforms grows and would have few hundred thousands subscribers.
The code looked like this : 
```ruby
Subscriber.all do |subscribers|
      subscribers.each do |subscriber|
        Rails.logger.info "Enqueuing #{subscriber.id}, article #{article_id}"
        ArticleMailerJob.perform_later(article_id, subscriber.id)
      end
    end
    ArticleMailerEnqueueJob.perform_later id
```
We asked the developer to fix this issue in order for the site to be able to scale easily without causing a massive cost raise. Few other problems were fixed by the developer that did not directly involve us, which I won't detail here.

Concerning redis we had to create a resque.rb file and a new variable in the .env file called REDIS_URL that contained the URL of redis database in order for it to be functioning nominally.

#### Kubernetes and Ingress related solution

### Makefile

In order for the developpers and us to make things easier to start the container we have to build a Makefile.
Let's start with ```make dev```
This commmand executes this : 
```bash
docker compose up -d --build
@sleep 10
docker exec -t crispy-octo-app-1 bundle exec rails db:migrate
docker exec -t crispy-octo-app-1 bundle exec rails db:fixtures:load
```

Then we have ```make tests```
that includes the following commands: 
```bash
docker exec -t crispy-octo-app-1 bundle exec rails db:environment:set RAILS_ENV=test 
docker exec -t crispy-octo-app-1 bundle exec rails test
```
But as you noticed we set the RAILS_ENV to test so we also have a command to change it back to development :
```make env_res```
it contains just this command : 
```bash
docker exec -t crispy-octo-app-1 bundle exec rails db:environment:set RAILS_ENV=development
```
