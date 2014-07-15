# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  session    :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe User, type: :model do
  describe '#valid?' do
    before { subject.session = session }

    context 'when the session is nil' do
      let(:session) { nil }

      it { should_not be_valid }
    end

    context 'when the session\'s length is not 32' do
      let(:session) { 'incorrect length' }

      it { should_not be_valid }
    end

    context 'when the sesssion\'s length is 32' do
      let(:session) { '0' * 32 }

      context 'when there is already User with an identical session' do
        before { subject.dup.save }
        after { User.where(session: session).delete_all }

        it { should_not be_valid }
      end

      context 'when there is not already a User with an identical session' do
        it { should be_valid }
      end
    end
  end
end
