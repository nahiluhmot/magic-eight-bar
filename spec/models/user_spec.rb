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

      it { be_valid }
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

  describe '#reviews' do
    subject! { User.create!(session: 32.times.map { rand(10) }.join) }
    let!(:bar) {
      Bar.create!(
        name: "The Bar",
        address: "4234 A Place, Boston, MA",
        place_id: 27.times.map { rand(10) }.join
      )
    }
    let!(:review) {
      Review.create!(user_id: subject['id'], bar_id: bar['id'], rating: 1)
    }

    after { [subject, bar, review].map(&:destroy) }

    it 'returns all of the reviews for the given bar' do
      expect(subject.reviews).to eq([review])
    end
  end

  describe '#create!' do
    context 'when the session is not set' do
      let(:user) { User.create! }
      let(:session) { user.session }

      it 'makes a new session' do
        expect(session).to be_a(String)
        expect(session.length).to eq(32)
      end
    end

    context 'when the session is set' do
      let(:user) { User.create!(session: session) }
      let(:session) { 32.times.map { rand(10) }.join }

      it 'uses that session' do
        expect(user.session).to eq(session)
      end
    end
  end
end
