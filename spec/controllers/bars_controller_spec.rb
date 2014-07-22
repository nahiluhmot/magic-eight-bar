require 'rails_helper'

describe BarsController, type: :controller do
  after { Bar.destroy_all }

  describe 'GET index' do
    let!(:bars) {
      10.times.map { |i|
        BarsService.create_bar(
          name: "Bar #{i}",
          address: "#{i} Test Street",
          place_id: 27.times.map { rand(10) }.join
        )
      }
    }

    it 'returns a list of all users' do
      get :index

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(bars)
    end
  end

  describe 'POST create' do
    context 'when not enough information is given' do
      it 'returns a 400' do
        post :create, name: 'Bad Bar'

        expect(response.status).to eq(400)
      end
    end

    context 'when enough information is given' do
      let(:bar) {
        {
          'name' => 'My Bar',
          'address' => '123 My Bar Street, Boston MA',
          'place_id' => 27.times.map { rand(10) }.join
        }
      }

      it 'returns a 201' do
        post :create, bar

        expect(response.status).to eq(201)
        expect(JSON.parse(response.body).tap { |h| h.delete('id') }).to eq(bar)
      end
    end
  end

  describe 'GET show' do
    let(:hash) {
      {
        'name' => 'Your Bar',
        'address' => '456 My Bar Street, Boston MA',
        'place_id' => 27.times.map { rand(10) }.join
      }
    }

    context 'when the bar cannot be found' do
      it 'returns a 404' do
        get :show, id: hash['place_id']

        expect(response.status).to eq(404)
      end
    end

    context 'when the bar can be found' do
      let!(:bar) { BarsService.create_bar(hash) }

      it 'returns the bar' do
        get :show, id: hash['place_id']

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(bar)
      end
    end
  end

  describe 'DELETE destroy' do
    let(:hash) {
      {
        'name' => 'A Bar',
        'address' => '789 My Bar Street, Boston MA',
        'place_id' => 27.times.map { rand(10) }.join
      }
    }

    context 'when the bar does not exist' do
      it 'returns a 400' do
        delete :destroy, id: hash['place_id']

        expect(response.status).to eq(400)
      end
    end

    context 'when the bar does exist' do
      before { BarsService.create_bar(hash) }

      it 'returns a 204' do
        expect { delete :destroy, id: hash['place_id'] }
          .to change { BarsService.all_bars.length }
          .by(-1)

        expect(response.status).to eq(204)
      end
    end
  end
end
