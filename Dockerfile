FROM ubuntu:18.04
MAINTAINER Maciej Litwiniuk <maciej@litwiniuk.net>

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install build-essential zlib1g-dev libssl-dev \
               libreadline6-dev libyaml-dev git-core \
               libcurl4-openssl-dev libpq-dev libmysqlclient-dev libxslt-dev \
               libsqlite3-dev libmagickwand-dev imagemagick \
			   python apt-utils

# Install node
ENV NODEJS_DOWNLOAD_SHA256 5b8a55d829d951d2a5ccefd4ffe4f9154673ebc621fd6c676bea09bba95cf96b
ADD https://nodejs.org/dist/v10.14.2/node-v10.14.2.tar.gz /tmp/

RUN \
  cd /tmp && \
  echo "$NODEJS_DOWNLOAD_SHA256 *node-v10.14.2.tar.gz" | sha256sum -c - && \
  tar xvzf node-v10.14.2.tar.gz && \
  rm -f node-v10.14.2.tar.gz && \
  cd node-v* && \
  ./configure && \
  make && \
  make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  echo -e '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc

RUN npm install -g yarn

ENV RUBY_DOWNLOAD_SHA256 9828d03852c37c20fa333a0264f2490f07338576734d910ee3fd538c9520846c
ADD https://cache.ruby-lang.org/pub/ruby/2.5/ruby-2.5.3.tar.gz /tmp/

# Install ruby
RUN \
  cd /tmp && \
  echo "$RUBY_DOWNLOAD_SHA256 *ruby-2.5.3.tar.gz" | sha256sum -c - && \
  tar -xzf ruby-2.5.3.tar.gz && \
  cd ruby-2.5.3 && \
  ./configure && \
  make && \
  make install && \
  cd .. && \
  rm -rf ruby-2.5.3 && \
  rm -f ruby-2.5.3.tar.gz

RUN gem install bundler --no-ri --no-rdoc
