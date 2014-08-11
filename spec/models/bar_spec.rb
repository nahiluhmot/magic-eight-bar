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

require 'rails_helper'

describe Bar, type: :model do
  describe '#valid?' do
    let(:hash) {
      {
        name: "Bob's Burgers",
        address: "1234 Some Place, Boston, MA",
        place_id: 27.times.map { rand(10) }.join,
        lat: rand(100),
        lon: rand(100)
      }
    }
    subject { Bar.new(hash) }

    context 'when the name is not present' do
      before { hash.delete(:name) }

      it { should_not be_valid }
    end

    context 'when the name is present' do
      context 'but the address is not present' do
        before { hash.delete(:address) }

        it { should_not be_valid }
      end

      context 'and the address is present' do
        context 'but the place_id is not present' do
          before { hash.delete(:place_id) }

          it { should_not be_valid }
        end

        context 'and the place_id is present' do
          context 'but it is not unique' do
            before { Bar.create(hash) }

            after { Bar.where(place_id: hash[:place_id]).destroy_all }

            it { should_not be_valid }
          end

          context 'and it is unique' do
            it { should be_valid }
          end
        end
      end
    end
  end

  describe '#reviews' do
    subject! {
      Bar.create!(
        name: "The Bar",
        address: "4234 A Place, Boston, MA",
        place_id: 27.times.map { rand(10) }.join,
        lat: 32,
        lon: -74
      )
    }
    let!(:user) { User.create!(session: 32.times.map { rand(10) }.join) }
    let!(:review) {
      Review.create!(user_id: user['id'], bar_id: subject['id'], rating: 1)
    }

    after { [subject, user, review].map(&:destroy) }

    it 'returns all of the reviews for the given bar' do
      expect(subject.reviews).to eq([review])
    end
  end
end
