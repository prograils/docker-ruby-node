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
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt install nodejs

RUN npm install -g yarn

ENV RUBY_DOWNLOAD_SHA256 369825db2199f6aeef16b408df6a04ebaddb664fb9af0ec8c686b0ce7ab77727
ADD https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.1.tar.gz /tmp/

# Install ruby
RUN \
  cd /tmp && \
  echo "$RUBY_DOWNLOAD_SHA256 *ruby-3.0.1.tar.gz" | sha256sum -c - && \
  tar -xzf ruby-3.0.1.tar.gz && \
  cd ruby-3.0.1 && \
    ./configure --enable-shared && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-3.0.1 && \
  rm -f ruby-3.0.1.tar.gz

RUN gem install bundler

