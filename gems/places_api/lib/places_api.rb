require 'excon'
require 'json'
require 'hashie'

# This is the top-level module for the gem.
module PlacesAPI
  module_function

  require 'places_api/middleware'
  require 'places_api/api'
end
