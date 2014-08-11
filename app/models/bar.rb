# == Schema Information
#
# Table name: bars
#
#  id         :integer          not null, primary key
#  name       :string(120)      not null
#  place_id   :string(40)       not null
#  address    :string(120)      not null
#  created_at :datetime
#  updated_at :datetime
#  lat        :decimal(11, 8)
#  lon        :decimal(11, 8)
#  website    :string(255)
#

class Bar < ActiveRecord::Base
  include MashAttributes

  validates :name, length: 1..120, uniqueness: true
  validates :place_id, uniqueness: true, presence: true
  validates :lat, presence: true
  validates :lon, presence: true
  validates :address, length: 1..120

  has_many :reviews
end
