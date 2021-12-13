FROM ubuntu:18.04
LABEL maintainer="maciej@litwiniuk.net"

RUN apt-get update && apt-get -y install build-essential zlib1g-dev libssl-dev \
  libreadline6-dev libyaml-dev git \
  libcurl4-openssl-dev libpq-dev libmysqlclient-dev libxslt-dev \
  libsqlite3-dev libmagickwand-dev imagemagick \
  python curl

# Install node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN apt-get -y install nodejs

RUN npm install -g yarn

ENV RUBY_DOWNLOAD_SHA256 1807b78577bc08596a390e8a41aede37b8512190e05c133b17d0501791a8ca6d
ADD https://cache.ruby-lang.org/pub/ruby/2.6/ruby-2.6.8.tar.gz /tmp/

# Install ruby
RUN \
  cd /tmp && \
  echo "$RUBY_DOWNLOAD_SHA256 *ruby-2.6.8.tar.gz" | sha256sum -c - && \
  tar -xzf ruby-2.6.8.tar.gz && \
  cd ruby-2.6.8 && \
  ./configure && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-2.6.8 && \
  rm -f ruby-2.6.8.tar.gz

RUN gem install bundler

