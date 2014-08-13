# This controller returns predictions for the logged in user
class PredictionsController < ApplicationController

  # Get the next prediction. Returns a status ofr 402 if the user is not logged
  # in.
  #
  # Sample:
  #   Request:
  #     path: /api/predictions/
  #     method: GET
  #     params: {}
  #     cookies:
  #       id: 79242894734700608109366522220280
  #   Response:
  #     content: application/json
  #     status: 200
  #     body:
  #       {
  #         "id": 199,
  #         "name": "Cheers",
  #         "place_id": "ChIJb7nX2YVw44kRtgHbmPtsymA",
  #         "address": "1 S Market St, Boston, MA, United States",
  #         "lat": "42.360116",
  #         "lon": "-71.055393",
  #         "website": "http://www.cheersboston.com/"
  #       }
  def next_prediction
    if user = User.where(session: cookies[:id]).first
      service = PredictionsService.new(user.id)
      bar = service.get_prediction
      bar ||= Bar.where.not(id: service.reviews.pluck(:bar_id)).to_a.sample

      render status: 200, json: bar.attributes.to_json
    else
      render status: 403, body: 'Nobody is logged in'
    end
  end
end
