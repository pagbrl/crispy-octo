FROM ruby:3.1.3-alpine AS builder

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

FROM ruby:3.1.3-alpine AS prod

WORKDIR /crispy-octo
RUN apk update && apk add --no-cache \
  build-base \
  mysql-dev 

COPY --from=builder /crispy-octo /crispy-octo

EXPOSE 3000

CMD [ "rails", "server", "-e", "production"]
