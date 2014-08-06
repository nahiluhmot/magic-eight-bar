FROM ubuntu:13.10

WORKDIR /tmp

# Install ruby 2.0.0
RUN apt-get -y update
RUN apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev wget
RUN wget http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p481.tar.gz
RUN tar -xvzf ruby-2.0.0-p481.tar.gz
RUN cd ruby-2.0.0-p481/ && ./configure --prefix=/usr/local && make && make install

# Install node
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get -y install nodejs npm
RUN npm install -g bower grunt-cli
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Build the app
RUN gem install bundler
RUN apt-get install -y sudo libmysqlclient-dev
RUN useradd magic -p magic
ADD . /app
RUN chown -R magic:magic /app
USER magic

WORKDIR /app/js
RUN npm install
USER root
RUN bower install --allow-root
RUN chown -R magic:magic bower_components/
USER magic

WORKDIR /app/gems/places_api
RUN bundle install --path vendor/bundle/

WORKDIR /app
RUN bundle install --path vendor/bundle/
RUN bundle exec rake js:rebuild
RUN source secrets
