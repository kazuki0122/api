FROM ruby:2.6.6
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client \
    yarn

RUN apt-get install -y cron 

WORKDIR /early-bird
COPY Gemfile Gemfile.lock /early-bird/
RUN bundle install
RUN service cron start 

# # cronをフォアグラウンド実行
CMD ["cron", "-f"] 