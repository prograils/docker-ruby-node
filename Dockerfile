FROM ubuntu:18.04
LABEL maintainer="maciej@litwiniuk.net"

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install build-essential zlib1g-dev libssl-dev \
  libreadline6-dev libyaml-dev git \
  libcurl4-openssl-dev libpq-dev libmysqlclient-dev libxslt-dev \
  libsqlite3-dev libmagickwand-dev imagemagick \
  python apt-utils curl

# Install node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get -y install nodejs

RUN npm install -g yarn

ENV RUBY_DOWNLOAD_SHA256 e4227e8b7f65485ecb73397a83e0d09dcd39f25efd411c782b69424e55c7a99e
ADD https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.7.tar.gz /tmp/

# Install ruby
RUN \
  cd /tmp && \
  echo "$RUBY_DOWNLOAD_SHA256 *ruby-2.6.7.tar.gz" | sha256sum -c - && \
  tar -xzf ruby-2.6.7.tar.gz && \
  cd ruby-2.6.7 && \
  ./configure && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-2.6.7 && \
  rm -f ruby-2.6.7.tar.gz

RUN gem install bundler

