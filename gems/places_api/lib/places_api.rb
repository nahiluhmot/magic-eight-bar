require 'excon'
require 'json'
require 'hashie'

# This is the top-level module for the gem.
module PlacesAPI
  require 'places_api/middleware'
  require 'places_api/api'
  require 'places_api/search'
  require 'places_api/client'

  # Return a new client.
  def self.new(api_key)
    PlacesAPI::Client.new(api_key)
  end
end
