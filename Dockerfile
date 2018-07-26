FROM ubuntu:16.04
MAINTAINER Maciej Litwiniuk <maciej@litwiniuk.net>

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install build-essential zlib1g-dev libssl-dev \
               libreadline6-dev libyaml-dev git-core \
               libcurl4-openssl-dev libpq-dev libmysqlclient-dev libxslt-dev \
               libsqlite3-dev libmagickwand-dev imagemagick

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

RUN npm install -g -g yarn

ENV RUBY_DOWNLOAD_SHA256 dac81822325b79c3ba9532b048c2123357d3310b2b40024202f360251d9829b1
ADD https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.1.tar.gz /tmp/

# Install ruby
RUN \
  cd /tmp && \
  echo "$RUBY_DOWNLOAD_SHA256 *ruby-2.5.1.tar.gz" | sha256sum -c - && \
  tar -xzf ruby-2.5.1.tar.gz && \
  cd ruby-2.5.1 && \
  ./configure && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-2.5.1 && \
  rm -f ruby-2.5.1.tar.gz

RUN gem install bundler --no-ri --no-rdoc
