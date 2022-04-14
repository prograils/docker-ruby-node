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

ENV RUBY_DOWNLOAD_SHA256 e7203b0cc09442ed2c08936d483f8ac140ec1c72e37bb5c401646b7866cb5d10
ADD https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.6.tar.gz /tmp/

# Install ruby
RUN \
  cd /tmp && \
  echo "$RUBY_DOWNLOAD_SHA256 *ruby-2.7.6.tar.gz" | sha256sum -c - && \
  tar -xzf ruby-2.7.6.tar.gz && \
  cd ruby-2.7.6 && \
    ./configure --enable-shared && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-2.7.6 && \
  rm -f ruby-2.7.6.tar.gz

RUN gem install bundler

