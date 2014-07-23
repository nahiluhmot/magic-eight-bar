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

require 'rails_helper'

describe Review, type: :model do
  describe '.valid?' do
    subject {
      Review.new(
        user_id: user.try { |b| b['id'] },
        bar_id: bar.try { |b| b['id'] },
        rating: rating
      )
    }
    let(:user) { UsersService.create_user }
    let(:bar) {
      BarsService.create_bar(
        name: 'Place',
        address: '213 Test Street',
        place_id: 27.times.map { rand(10) }.join
      )
    }
    let(:rating) { 1 }

    context 'when the user is nil' do
      let(:user) { nil }

      it { should_not be_valid }
    end

    context 'when the user is present' do
      context 'when the bar is nil' do
        let(:bar) { nil }

        it { should_not be_valid }
      end

      context 'when the bar is present' do
        context 'when the rating is nil' do
          let(:rating) { nil }

          it { should_not be_valid }
        end

        context 'when the rating is present' do
          context 'when there already is a review for that user and bar' do
            let!(:other_review) { subject.dup.tap(&:save!) }

            after { other_review.destroy }

            it { should_not be_valid }
          end

          context 'when there is no review yet' do
            context 'when the rating is not -1, 0, or 1' do
              let(:rating) { 2 }
              it { should_not be_valid }
            end

            [-1, 0, 1].each do |n|
              context "when the rating is #{n}" do
                let(:rating) { n }

                it { should be_valid }
              end
            end
          end
        end
      end
    end
  end
end
