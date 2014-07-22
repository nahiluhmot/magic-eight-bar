# This is the top-level API, under which all other APIs are mounted.
class PlacesAPI::Client < PlacesAPI::API
  mount :search, PlacesAPI::Search

  request name: 'details', path: 'details', method: 'GET', required: [], &:first
end
