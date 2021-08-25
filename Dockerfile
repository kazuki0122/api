FROM ruby:2.6.6
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client \
    yarn

WORKDIR /early-bird
COPY Gemfile Gemfile.lock /early-bird/
RUN bundle install