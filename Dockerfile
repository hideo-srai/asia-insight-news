FROM ruby:2.1.7
RUN apt-get update -qq && apt-get install -y build-essential nodejs

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile BUNDLE_PATH=/gems
RUN bundle install

ADD . $APP_HOME

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
