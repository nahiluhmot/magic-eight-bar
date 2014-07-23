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
  validates :session, length: { is: 32 }, uniqueness: true
  has_many :reviews

  def attributes
    super.tap { |hash| %w(created_at updated_at).each { |k| hash.delete(k) } }
  end
end
