FROM ruby:2.6.3


# -qq: show only errors occurs, -y: answer all inquiries "yes"
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

RUN mkdir /bookers2_sample
ENV APP_ROOT /bookers2_sample

WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install
ADD . $APP_ROOT