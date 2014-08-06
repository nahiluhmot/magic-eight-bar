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

  before_validation(on: :create) { self.session ||= sessions.next }

  has_many :reviews

  private

  # This is an infinite enumerator of unique sessions.
  def sessions
    return enum_for(:sessions) unless block_given?
    loop do
      session = 32.times.map { rand(10) }.join
      yield session unless User.exists?(session)
    end
  end
end
