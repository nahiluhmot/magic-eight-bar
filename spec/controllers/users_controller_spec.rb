require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET index' do
    before { User.destroy_all }
    after { User.destroy_all }

    it 'returns a list of all users' do
      users = 5.times.map { UsersService.create_user }
      get :index

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(users)
    end
  end

  describe 'POST create' do
    after { User.destroy_all }
    it 'sets cookies[:id]' do
      post :create

      expect(response.status).to eq(201)
      expect(response.cookies['id'].length).to eq(32)
    end
  end

  describe 'GET show' do
    context 'when the user does not exist' do
      it 'returns a 404' do
        get :show, id: 'lol-not-an-id'

        expect(response.status).to eq(404)
      end
    end

    context 'when the user does exist' do
      let(:user) { UsersService.create_user }
      let(:id) { user['session'] }

      it 'returns a 200' do
        get :show, id: id

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(user)
      end
    end
  end
end
