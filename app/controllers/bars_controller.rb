# This controller handles bar lifecycle.
class BarsController < ApplicationController
  # Return all of the bars.
  #
  # Sample:
  #   Request:
  #     path: /api/bars/
  #     method: GET
  #     params: {}
  #   Response:
  #     content: application/json
  #     status: 200
  #     body:
  #       [
  #         {
  #           "id": 199,
  #           "name": "Cheers",
  #           "place_id": "ChIJb7nX2YVw44kRtgHbmPtsymA",
  #           "address": "1 S Market St, Boston, MA, United States",
  #           "lat": "42.360116",
  #           "lon": "-71.055393",
  #           "website": "http://www.cheersboston.com/"
  #         },
  #         ...
  #       ]
  def index
    logger.debug('Listing all bars')
    render status: 200, json: Bar.all.to_json
  rescue => ex
    logger.error("Could not list bars due to #{ex.class}:#{ex.message}")
    render status: 500, body: nil
  end
end
