require 'rails_helper'

describe BarsController, type: :controller do
  after { Bar.destroy_all }

  describe 'GET index' do
    let!(:bars) {
      10.times.map { |i|
        Bar.create!(
          name: "Bar #{i}",
          address: "#{i} Test Street",
          place_id: 27.times.map { rand(10) }.join
        )
      }
    }

    it 'returns a list of all users' do
      get :index

      expect(response.status).to eq(200)
      expect(response.body).to eq(bars.to_json)
    end
  end
end
