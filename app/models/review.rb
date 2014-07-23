# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  bar_id     :integer
#  rating     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :bar

  validates_associated :user, :bar
  validates :user, :bar, presence: true

  validate do |review|
    if review.rating.nil?
      review.errors[:rating] << 'No rating was given'
    elsif (review.rating < -1) || (review.rating > 1)
      review.errors[:rating] << "Invalid rating: #{review.rating}"
    end
  end

  def attributes
    super.tap { |hash| %w(created_at updated_at).each { |k| hash.delete(k) } }
  end
end
