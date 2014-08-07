require 'rails_helper'

describe PredictionsController, type: :controller do
  describe 'GET show' do
    context 'when there is no user logged in' do
      it 'returns a 403' do
        get :next_prediction

        expect(response.status).to eq(403)
      end
    end

    context 'when there is a user logged in' do
      let(:user) { User.create! }
      let(:bar) {
        Bar.new(
          name: 'Punter\'s',
          place_id: 'Test',
          address: 'some address',
          lat: 32,
          lon: -74
        )
      }

      before do
        Bar.destroy_all
        bar.save!
      end

      it 'returns the next prediction' do
        @request.cookies[:id] = user.session
        get :next_prediction

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)['id']).to eq(bar.id)
      end
    end
  end
end
