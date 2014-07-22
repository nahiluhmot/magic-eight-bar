require 'spec_helper'

describe PlacesAPI do
  describe '.new' do
    subject { PlacesAPI.new(api_key) }
    let(:api_key) { 'test-api-key' }

    it 'returns a new client' do
      expect(subject).to be_a(PlacesAPI::Client)
      expect(subject.api_key).to eq(api_key)
    end
  end
end
