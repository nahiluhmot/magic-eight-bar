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
#

class Bar < ActiveRecord::Base
  validates :name, length: 1..120
  validates :place_id, uniqueness: true, presence: true
  validates :address, length: 1..120

  def attributes
    super.tap { |hash| %w(created_at updated_at).each { |k| hash.delete(k) } }
  end
end
