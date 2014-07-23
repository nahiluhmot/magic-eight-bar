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
  include MashAttributes

  belongs_to :user
  belongs_to :bar

  validates_associated :user, :bar
  validates :user, :bar, presence: true

  validate do |review|
    if review.rating.nil?
      review.errors[:rating] << 'not given'
    elsif (review.rating < -1) || (review.rating > 1)
      review.errors[:rating] << "invalid: #{review.rating}"
    end

    if review.user_id.nil?
      review.errors[:user] << 'not given'
    elsif review.bar.nil?
      review.errors[:bar] << 'not given'
    elsif review.duplicate_exists?
      review.errors[:review] << "exists for User #{user.id}, Bar #{bar.id}"
    end
  end

  def duplicate_exists?
    id.nil? && Review.exists?(user_id: user_id, bar_id: bar_id)
  end
end
