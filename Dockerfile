FROM ruby:2.6

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
RUN apt-get update && apt-get install cron -y
ENV LANG C.UTF-8

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["./bin/start.sh"]
