# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  session    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  include MashAttributes

  validates :session, length: { is: 32 }, uniqueness: true
  has_many :reviews
end
