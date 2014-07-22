# This class allows us to declaratively define interfaces to Google APIs.
class PlacesAPI::API
  attr_reader :api_key

  # This error is raised when a request fails.
  RequestError = Class.new(StandardError)

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
    params[:expects] = (200..204)
    unpaginate(params)
  rescue Excon::Errors::Error => ex
    raise RequestError, ex.message
  end

  # A HTTP connection to the server.
  def connection
    @connection ||=
      Excon.new('https://maps.googleapis.com', middlewares: MIDDLEWARES)
  end

  def unpaginate(params, &block)
    return enum_for(:unpaginate, params) if block.nil?

    response = connection.request(params).body
    response['results'].each(&block) unless response['results'].nil?
    block.call(response['result']) unless response['result'].nil?

    if token = response['next_page_token']
      new_params = params.merge(query: { pagetoken: token })
      unpaginate(new_params).each { |val| block.call(val) }
    end
  end
  private :unpaginate

  # These class methods are inheirited as well as the instance methods.
  class << self
    # Define a request.
    def request(options = {}, &block)
      method, required, path, name =
        options.values_at(:method, :required, :path, :name)
      required = [*required]
      define_method(name) do |*args|
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
