FROM ubuntu:18.04
LABEL maintainer="maciej@litwiniuk.net"

RUN apt-get update && apt-get -y install build-essential zlib1g-dev libssl-dev \
  libreadline6-dev libyaml-dev git \
  libcurl4-openssl-dev libpq-dev libmysqlclient-dev libxslt-dev \
  libsqlite3-dev libmagickwand-dev imagemagick \
  python apt-utils curl ca-certificates

# Install node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt install nodejs

RUN npm install -g yarn

ENV RUBY_DOWNLOAD_SHA256 2755b900a21235b443bb16dadd9032f784d4a88f143d852bc5d154f22b8781f1
ADD https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.5.tar.gz /tmp/

# Install ruby
RUN \
  cd /tmp && \
  echo "$RUBY_DOWNLOAD_SHA256 *ruby-2.7.5.tar.gz" | sha256sum -c - && \
  tar -xzf ruby-2.7.5.tar.gz && \
  cd ruby-2.7.5 && \
  ./configure --enable-shared && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-2.7.5 && \
  rm -f ruby-2.7.5.tar.gz

RUN gem install bundler

