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
end
