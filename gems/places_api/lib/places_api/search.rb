# This class is used to search the Google Places API.
class PlacesAPI::Search < PlacesAPI::API
  request name: 'nearby',
          path: 'nearbysearch',
          method: 'GET',
          required: :location

  request name: 'text',
          path: 'textsearch',
          method: 'GET',
          required: :query

  request name: 'radar',
          path: 'radarsearch',
          method: 'GET',
          required: :location
end
