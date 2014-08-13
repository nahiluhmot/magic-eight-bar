class PredictionsService
  attr_reader :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def get_prediction
    bar_ids = Review.where(user_id: best_friends, rating: 1)
                    .where.not(bar_id: reviews.pluck(:bar_id))
                    .pluck(:bar_id)
    bar_id = max_frequency(bar_ids)
    bar_id.nil? ? nil : Bar.find(max_frequency(bar_ids))
  end

  def best_friends
    @best_friends ||= begin
      users_with_scores = Hash.new(0)
      other_reviews = Review.where(bar_id: reviews.pluck(:bar_id))
                            .where.not(user_id: user_id)

      other_reviews.find_each do |review|
        if my_review = reviews.where(bar_id: review.bar_id).first
          if my_review.rating == review.rating
            users_with_scores[review.user_id] += 1
          else
            users_with_scores[review.user_id] -= 1
          end
        end
      end

      users_with_scores.select { |_, v| v > 0 }.sort_by { |_, v| -1 * v }.take(10).map(&:first)
    end
  end

  def reviews
    @reviews ||= Review.where(user_id: user_id)
  end

  def max_frequency(list)
    hash = list.each_with_object(Hash.new(0)) { |k, h| h[k] += 1 }
    list.max_by { |value| hash[value] }
  end
end
