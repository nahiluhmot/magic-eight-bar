FROM ubuntu:14.04

WORKDIR /tmp

# Install ruby 2.0.0
RUN apt-get -y update
RUN apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev wget nodejs npm libmysqlclient-dev nginx
RUN wget http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p481.tar.gz
RUN tar -xvzf ruby-2.0.0-p481.tar.gz
RUN cd ruby-2.0.0-p481/ && ./configure --prefix=/usr/local && make && make install
RUN gem install bundler

# Install node
RUN npm install -g bower grunt-cli
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN rm -rf /tmp

# Add the application
RUN useradd magic -p magic
ADD . /app
RUN chown -R magic:magic /app
USER magic

# Build the places_api gem
WORKDIR /app/gems/places_api
RUN bundle install --deployment --jobs 8

# Build the node application
WORKDIR /app
RUN npm install
USER root
RUN bower install --allow-root --production
RUN chown -R magic:magic bower_components/
RUN grunt

# Build the ruby applictaion
USER magic
RUN bundle install --deployment --jobs 8
