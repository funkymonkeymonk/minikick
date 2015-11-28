FROM ruby:2.2
MAINTAINER Will Weaver<monkey@buildingbananas.com>

COPY Gemfile /tmp/
COPY Gemfile.lock /tmp/
COPY *.gemspec /tmp/

WORKDIR /tmp/
RUN bundle install

COPY . /usr/src/app
WORKDIR /usr/src/app

CMD /bin/bash
