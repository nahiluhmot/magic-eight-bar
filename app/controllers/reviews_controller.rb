# This controller handles bar lifecycle.
class ReviewsController < ApplicationController
  # Get all of the reviews for the logged in user. Returns a 403 if nobody is
  # logged in.
  #
  # Sample:
  #   Request:
  #     path: /api/reviews/
  #     method: GET
  #     params: {}
  #     cookies:
  #       id: 79242894734700608109366522220280
  #   Response:
  #     content: application/json
  #     status: 200
  #     body:
  #       [
  #         {
  #           "id": 199,
  #           "bar_id": 50,
  #           "user_id": 30,
  #           "rating": 1
  #         },
  #         ...
  #       ]
  def index
    when_logged_in do |user|
      render status: 200, json: Review.where(user_id: user.id).to_json
    end
  end

  # Create a new review for the logged in user. Returns a 403 if nobody is
  # logged in, and a 400 if the rating is invalid.
  #
  # Sample:
  #   Request:
  #     path: /api/reviews/
  #     method: POST
  #     body: { bar_id: 50, rating: 1 }
  #     cookies:
  #       id: 79242894734700608109366522220280
  #   Response:
  #     content: application/json
  #     status: 200
  #     body:
  #       {
  #         "id": 199,
  #         "bar_id": 50,
  #         "user_id": 30,
  #         "rating": 1
  #       }
  def create
    when_logged_in do
      rating = params[:rating].to_i

      if [-1, 0, 1].include?(rating)
        review = Review.create!(params.permit(:user_id, :bar_id, :rating))
        render status: 201, json: review.attributes.to_json
      else
        render status: 400, body: "Invalid rating: #{rating}"
      end
    end
  rescue => ex
    logger.error("Could not create review due to #{ex.class}: #{ex.message}")
    render status: 400, json: ex.message
  end

  private

  def when_logged_in(&block)
    if (params[:user_id] = current_user.try(&:id)).present?
      block.call(current_user)
    else
      render status: 403, body: 'Unauthorized'
    end
  end

  def current_user
    User.where(session: cookies[:id]).first
  end
end
