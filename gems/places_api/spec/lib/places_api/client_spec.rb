require 'places_api'

describe PlacesAPI::Client do
  subject { PlacesAPI::Client.new(ENV['GOOGLE_PLACES_API_KEY']) }

  before do
    if ENV['GOOGLE_PLACES_API_KEY'].nil?
      raise "Please set ENV['GOOGLE_PLACES_API_KEY'] to run these tests"
    end
  end

  describe '#search' do
    it 'returns a handle to an instance of PlacesAPI::Search' do
      expect(subject.search).to be_a(PlacesAPI::Search)
    end
  end

  describe '#details' do
    let(:placeid) {
      subject.search.nearby('42.3581,-71.0636', radius: 1000).first.place_id
    }

    it 'returns the details of a given Place' do
      expect(subject.details(placeid: placeid)).to be_a(Hashie::Mash)
    end
  end
end
