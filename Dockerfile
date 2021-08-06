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

RUN apt install nodejs

RUN npm install -g yarn

ENV RUBY_DOWNLOAD_SHA256 5085dee0ad9f06996a8acec7ebea4a8735e6fac22f22e2d98c3f2bc3bef7e6f1
ADD https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.2.tar.gz /tmp/

# Install ruby
RUN \
  cd /tmp && \
  echo "$RUBY_DOWNLOAD_SHA256 *ruby-3.0.2.tar.gz" | sha256sum -c - && \
  tar -xzf ruby-3.0.2.tar.gz && \
  cd ruby-3.0.2 && \
    ./configure --enable-shared && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-3.0.2 && \
  rm -f ruby-3.0.2.tar.gz

RUN gem install bundler

