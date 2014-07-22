$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'rspec'
require 'pry'
require 'simplecov'
SimpleCov.start

require 'places_api'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
