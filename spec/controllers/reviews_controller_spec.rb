require 'rails_helper'

describe ReviewsController, type: :controller do
  describe 'GET index' do
    context 'when the user is not signed in' do
      it 'returns a 400' do
        get :index

        expect(response.status).to eq(403)
      end
    end

    context 'when a user is signed in' do
      let(:user) { User.create! }

      let(:bar) {
        Bar.create!(
          name: 'Bar Louie',
          place_id: 'abcd',
          address: 'test address'
        )
      }
      let!(:reviews) {
        [Review.create!(user_id: user.id, bar_id: bar.id, rating: 1)]
      }

      it 'returns a 200' do
        @request.cookies['id'] = user.session
        get :index, user_id: user.id

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(reviews.map(&:attributes))
      end
    end
  end

  describe 'POST create' do
    context 'when the user is not signed in' do
      it 'returns a 403' do
        post :create, user_id: 1, bar_id: 1, rating: 1

        expect(response.status).to eq(403)
      end
    end

    context 'when a user is signed in' do
      let(:user) { User.create! }
      let(:bar) {
        Bar.create!(
          name: 'Yard House',
          place_id: 'ABCD',
          address: 'test'
        )
      }
      before { @request.cookies['id'] = user.session }

      context 'when an invalid review is given' do
        it 'returns a 400' do
        post :create, user_id: user.id, bar_id: bar.id, rating: -2

        expect(response.status).to eq(400)
        end
      end

      context 'when a valid review is created' do
        let(:review) { JSON.parse(response.body) }

        it 'creates a review' do
          post :create, user_id: user.id, bar_id: bar.id, rating: 1

          expect(response.status).to eq(201)
          expect(review['user_id']).to eq(user.id)
          expect(review['bar_id']).to eq(bar.id)
          expect(review['rating']).to eq(1)
        end
      end
    end
  end
end

