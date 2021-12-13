FROM ubuntu:18.04
LABEL maintainer="maciej@litwiniuk.net"

RUN apt-get update && apt-get -y install build-essential zlib1g-dev libssl-dev \
  libreadline6-dev libyaml-dev git \
  libcurl4-openssl-dev libpq-dev libmysqlclient-dev libxslt-dev \
  libsqlite3-dev libmagickwand-dev imagemagick \
  python curl

# Install node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

RUN apt install nodejs

RUN npm install -g yarn

ENV RUBY_DOWNLOAD_SHA256 3586861cb2df56970287f0fd83f274bd92058872d830d15570b36def7f1a92ac
ADD https://cache.ruby-lang.org/pub/ruby/3.0/ruby-3.0.3.tar.gz /tmp/

# Install ruby
RUN \
  cd /tmp && \
  echo "$RUBY_DOWNLOAD_SHA256 *ruby-3.0.3.tar.gz" | sha256sum -c - && \
  tar -xzf ruby-3.0.3.tar.gz && \
  cd ruby-3.0.3 && \
    ./configure --enable-shared && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-3.0.3 && \
  rm -f ruby-3.0.3.tar.gz

RUN gem install bundler

