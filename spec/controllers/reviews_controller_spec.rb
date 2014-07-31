require 'rails_helper'

describe ReviewsController, type: :controller do
  describe 'GET index' do
    context 'when the user is not signed in' do
      it 'returns a 400' do
        get :index

        expect(response.status).to eq(400)
      end
    end

    context 'when a user is signed in' do
      let(:user) { UsersService.create_user }

      before { request.cookies['id'] = user.session }

      context 'but it is the wrong user' do
        it 'returns a 403' do
          get :index, user_id: user.id.succ

          expect(response.status).to eq(403)
        end
      end

      context 'when the correct user is logged in' do
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

        it 'returns the User\'s reviews' do
          pending
        end
      end
    end
  end

  describe 'POST create' do
    context 'when the user is not signed in' do
      it 'returns a 400' do
        pending
      end
    end

    context 'when a user is signed in' do
      context 'but it is the wrong user' do
        it 'returns a 403' do
          pending
        end
      end

      context 'when the correct user is logged in' do
        context 'when an invalid review is give' do
          it 'returns a 400' do
            pending
          end
        end

        context 'when a valid review is created' do
          it 'returns a 201' do
            pending
          end

          it 'creates the review' do
            pending
          end
        end
      end
    end
  end
end

