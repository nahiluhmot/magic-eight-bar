require 'excon'
require 'json'
require 'hashie'

# This is the top-level module for the gem.
module PlacesAPI
  module_function

  require 'places_api/middleware'

  # By default, read the api_key from the $GOOGLE_PLACES_API_KEY environment
  # variable.
  def api_key
    @api_key ||= ENV['GOOGLE_PLACES_API_KEY']
  end

  # Set the api_key programitacally.
  def api_key=(new_key)
    @api_key = new_key
  end
end
