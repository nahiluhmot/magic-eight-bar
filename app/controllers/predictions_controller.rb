# This controller returns predictions for the logged in user
class PredictionsController < ApplicationController
  # Get the next prediction.
  def next_prediction
    if user = User.where(session: cookies[:id]).first
      bar_ids = Review.where(user_id: user.id).pluck(:bar_id).uniq
      bar = Bar.where.not(id: bar_ids).to_a.sample
      render status: 200, json: bar.attributes.to_json
    else
      render status: 403, body: 'Nobody is logged in'
    end
  end
end
