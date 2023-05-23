FROM ruby:3.1.3 AS builder

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev &&\
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

WORKDIR /crispy-octo
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY ./ /crispy-octo/



FROM ruby:3.1.3 AS prod 

WORKDIR /crispy-octo

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

COPY --from=builder /crispy-octo /crispy-octo

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
