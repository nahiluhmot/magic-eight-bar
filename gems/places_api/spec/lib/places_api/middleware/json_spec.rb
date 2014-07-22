require 'spec_helper'

describe PlacesAPI::Middleware::JSON do
  subject {
    Excon.new(
      'http://example.com',
      middlewares: [PlacesAPI::Middleware::JSON] + Excon.defaults[:middlewares],
      mock: true
    )
  }

  after { Excon.stubs.clear }

  describe 'requests' do
    context 'when the request\'s type is JSON' do
      let(:request_body) { { alpha: 1, beta: 2 } }
      let(:expected) { request_body.to_json }

      it 'converts the body to JSON' do
        Excon.stub({}, lambda { |req|
          expect(req[:body]).to eq(expected)
          { body: 'success', status: 200 }
        })

        subject.post(
          path: '/api/test',
          headers: { 'Content-Type' => 'application/json' },
          body: request_body
        )
      end
    end

    context 'when the request\'s type is not JSON' do
      let(:request_body) { 'my-request-body' }
      let(:expected) { request_body }

      it 'does nothing' do
        Excon.stub({}, lambda { |req|
          expect(req[:body]).to eq(expected)
          { body: 'success', status: 200 }
        })

        subject.post(
          path: '/api/test',
          headers: { 'Content-Type' => 'text/plain' },
          body: request_body
        )
      end
    end
  end

  describe 'responses' do
    context 'when the responses\'s type is JSON' do
      let(:expected) { { 'alpha' => 1, 'beta' => 2 } }
      let(:response_body) { expected.to_json }

      it 'converts the body to JSON' do
        Excon.stub({}, lambda { |req|
          {
            headers: { 'Content-Type' => 'application/json' },
            body: response_body,
            status: 200
          }
        })

        expect(subject.get(path: '/api/test').body).to eq(expected)
      end
    end

    context 'when the responses\'s type is not JSON' do
      let(:expected) { 'test-output' }
      let(:response_body) { expected }

      it 'converts the body to JSON' do
        Excon.stub({}, lambda { |req|
          {
            body: response_body,
            status: 200
          }
        })

        expect(subject.get(path: '/api/test').body).to eq(expected)
      end
    end
  end
end
