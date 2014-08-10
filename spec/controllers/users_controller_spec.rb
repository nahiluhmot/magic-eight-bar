require 'rails_helper'

describe UsersController, type: :controller do
  describe 'POST create' do
    after { User.destroy_all }
    it 'sets cookies[:id]' do
      post :create

      expect(response.status).to eq(201)
      expect(response.cookies['id'].length).to eq(32)
    end
  end

  describe 'GET valid?' do
    context 'when the request has no cookies' do
      it 'returns a 404' do
        get :valid?

        expect(response.status).to eq(404)
      end
    end

    context 'when the request has the correct cookie set' do
      before { @request.cookies['id'] = cookie }

      context 'but the cookie does not correspond to a valid user' do
        let(:cookie) { 'lol fake cookie' }

        it 'returns a 404' do
          get :valid?

          expect(response.status).to eq(404)
        end
      end

      context 'and the cookie corresponds to a valid user' do
        let(:cookie) { User.create.session }

        it 'returns a 200' do
          get :valid?

          expect(response.status).to eq(200)
        end
      end
    end
  end
end
