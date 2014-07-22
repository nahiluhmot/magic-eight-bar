require 'spec_helper'

describe PlacesAPI::Middleware::Domain do
  subject {
    Excon.new(
      'http://example.com',
      middlewares:
        [PlacesAPI::Middleware::Domain] + Excon.defaults[:middlewares],
      mock: true
    )
  }

  after { Excon.stubs.clear }

  describe 'requests' do
    it 'fixes the path' do
      Excon.stub({}, lambda { |req|
        expect(req[:path]).to eq('/maps/api/place/example/json')
        { body: '', status: 200 }
      })

      subject.request(path: 'example')
    end

    it 'sets the host' do
      Excon.stub({}, lambda { |req|
        expect(req[:headers]['Host']).to eq('maps.googleapis.com')
        { body: '', status: 200 }
      })

      subject.request(path: 'example')
    end
  end
end
