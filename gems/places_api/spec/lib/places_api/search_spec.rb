require 'spec_helper'

describe PlacesAPI::Search do
  subject { PlacesAPI::Search.new(ENV['GOOGLE_PLACES_API_KEY']) }

  before do
    if ENV['GOOGLE_PLACES_API_KEY'].nil?
      raise "Please set ENV['GOOGLE_PLACES_API_KEY'] to run these tests"
    end
  end

  describe '#nearby' do
    let(:results) { subject.nearby('42.3581,-71.0636', radius: 1000).to_a }

    it 'returns nearby locations' do
      expect(results.length).to eq(20)
      expect(results).to be_all { |result| result.is_a?(Hashie::Mash) }
      expect(results).to be_none { |result| result.place_id.nil? }
    end
  end

  describe '#text' do
    let(:results) { subject.text('Bars near Boston, MA').to_a }

    it 'returns a list of locations' do
      expect(results.length).to eq(20)
      expect(results).to be_all { |result| result.is_a?(Hashie::Mash) }
      expect(results).to be_none { |result| result.place_id.nil? }
    end
  end

  describe '#radar' do
    let(:results) {
      subject.radar('42.3581,-71.0636', radius: 5000, types: 'bar').to_a
    }

    it 'returns many results' do
      expect(results.length).to eq(200)
      expect(results).to be_all { |result| result.is_a?(Hashie::Mash) }
      expect(results).to be_none { |result| result.place_id.nil? }
    end
  end
end
