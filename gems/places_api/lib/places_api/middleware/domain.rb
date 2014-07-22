# This middleware holds domain-specific logic for requests.
class PlacesAPI::Middleware::Domain < Excon::Middleware::Base
  # Modify the request path.
  def request_call(datum)
    datum[:path] = "/maps/api/place#{datum[:path]}/json"
    (datum[:headers] ||= {})['Host'] = 'maps.googleapis.com'

    @stack.request_call(datum)
  end
end
