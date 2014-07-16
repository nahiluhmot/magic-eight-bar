require 'spec_helper'

describe PlacesAPI do
  describe '.api_key' do
    let!(:original) { subject.api_key }
    let(:test_key) { 'test-key' }

    before { subject.api_key = nil }
    after { subject.api_key = original }

    context 'when the API key has not been set' do
      let!(:original_env) {
        ENV['GOOGLE_PLACES_API_KEY']
      }

      before { ENV['GOOGLE_PLACES_API_KEY'] = test_key }
      after { ENV['GOOGLE_PLACES_API_KEY'] = original_env }

      it 'reads from $GOOGLE_PLACES_API_KEY' do
        expect(subject.api_key).to eq(test_key)
      end
    end

    context 'when the API key has been set' do
      it 'returns that version' do
        expect { subject.api_key = test_key }
          .to change { subject.api_key }
          .from(nil)
          .to(test_key)
      end
    end
  end
end
