FROM ubuntu:16.04
MAINTAINER Maciej Litwiniuk <maciej@litwiniuk.net>

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install build-essential zlib1g-dev libssl-dev \
               libreadline6-dev libyaml-dev git-core \
               libmagickwand-dev imagemagick libcurl4-openssl-dev

# Install node
ENV NODEJS_DOWNLOAD_SHA256 2c7a643b199c63390f4e33359e82f1449b84ec94d647c606fc0f1d1a2b5bdedd
ADD https://nodejs.org/dist/v6.10.1/node-v6.10.1.tar.gz /tmp/

RUN \
  cd /tmp && \
  echo "$NODEJS_DOWNLOAD_SHA256 *node-v6.10.1.tar.gz" | sha256sum -c - && \
  tar xvzf node-v6.10.1.tar.gz && \
  rm -f node-v6.10.1.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  echo -e '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc

# Common ruby/gems dependencies
RUN apt-get -y install libpq-dev libmysqlclient-dev libxslt-dev libsqlite3-dev libmagickwand-dev imagemagick

ENV RUBY_DOWNLOAD_SHA256 a330e10d5cb5e53b3a0078326c5731888bb55e32c4abfeb27d9e7f8e5d000250
ADD https://cache.ruby-lang.org/pub/ruby/2.4/ruby-2.4.1.tar.gz /tmp/

# Install ruby
RUN \
  cd /tmp && \
  echo "$RUBY_DOWNLOAD_SHA256 *ruby-2.4.1.tar.gz" | sha256sum -c - && \
  tar -xzf ruby-2.4.1.tar.gz && \
  cd ruby-2.4.1 && \
  ./configure && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-2.4.1 && \
  rm -f ruby-2.4.1.tar.gz

RUN gem install bundler --no-ri --no-rdoc

