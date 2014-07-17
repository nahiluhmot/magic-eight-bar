# This class allows us to declaratively define interfaces to Google APIs.
class PlacesAPI::API
  attr_reader :api_key

  # These middlewares are used in the excon connection.
  MIDDLEWARES = [
    PlacesAPI::Middleware::Domain,
    PlacesAPI::Middleware::JSON,
    *Excon.defaults[:middlewares]
  ]

  # Create a new API.
  def initialize(api_key)
    @api_key = api_key
  end

  # Make a request to the API.
  def request(params = {}, &block)
    (params[:query] ||= {}).merge!(key: api_key)
    connection.request(params, &block)
  end

  # A HTTP connection to the server.
  def connection
    @connection ||=
      Excon.new('https://maps.googleapis.com', middlewares: MIDDLEWARES)
  end

  # These class methods are inheirited as well as the instance methods.
  class << self
    # Define a request.
    def request(options = {})
      method, required, path, name =
        options.values_at(:method, :required, :path, :name)
      required = [*required]
      define_method(name) do |*args, &block|
        opts = args.last.is_a?(Hash) ? args.pop : {}
        unless required.length == args.length
          raise ArgumentError,
            "Expected #{required.length} args, got: #{args.length}"
        end
        required.zip(args).each { |k, v| opts[k] = v }
        resp = request(method: method, path: path, query: opts)
        block.nil? ? resp : block.call(resp)
      end
    end

    # Mount a sub-API
    def mount(name, klass)
      ivar = :"@__#{name}"
      define_method(name) do
        value = instance_variable_get(ivar)
        if value.nil?
          instance_variable_set(ivar, klass.new(api_key))
        else
          value
        end
      end
    end
  end
end
