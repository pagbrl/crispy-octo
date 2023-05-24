FROM ruby:3.1.3-alpine

RUN apk update && apk add --no-cache \
  curl \
  vim \
  jq \
  git \
  build-base \
  mysql-dev 

WORKDIR /crispy-octo
COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .
RUN cp .env.dist .env

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]