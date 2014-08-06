# This controller handles bar lifecycle.
class ReviewsController < ApplicationController
  # Show all of the reviews, they may be queried by their user_id, bar_id, or
  # both.
  def index
    when_logged_in do |user|
      render status: 200, json: Review.where(user_id: user.id).to_json
    end
  end

  # Create a review.
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
    logger.error("Could not create user due to #{ex.class}: #{ex.message}")
    render stauts: 400, json: ex.message
  end

  private

  def when_logged_in(&block)
    if params[:user_id].nil?
      render status: 400, body: 'No user_id given'
    elsif current_user.try(&:id) == params[:user_id].to_i
      block.call(current_user)
    else
      render status: 403, body: 'Unauthorized'
    end
  end

  def current_user
    User.where(session: cookies[:id]).first
  end
end
