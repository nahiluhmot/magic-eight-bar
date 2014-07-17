require 'spec_helper'

describe PlacesAPI::API do
  subject { PlacesAPI::API.new(api_key) }
  let(:api_key) { 'trust_no_1' }

  describe '#initialize' do
    it 'sets the @api_key' do
      expect(subject.api_key).to eq(api_key)
    end
  end

  describe '#request' do
    let(:params) { { method: 'post', path: 'yolo' } }
    let(:expected) { params.merge(query: { key: api_key }) }

    it 'sets the API key in addition to other parameters' do
      expect(subject.connection).to receive(:request).with(expected)

      subject.request(params)
    end
  end

  describe '#connection' do
    it 'should be an HTTP connection' do
      expect(subject.connection).to be_a(Excon::Connection)
    end
  end

  describe '.request' do
    subject { test_class.new(api_key) }
    let(:test_class) {
      Class.new(PlacesAPI::API).tap do |klass|
        klass.request method: 'post',
                      required: [:name, :email],
                      path: 'test',
                      name: 'my_method'
      end
    }

    context 'when the wrong number of arguments are passed' do
      it 'raises an error' do
        expect { subject.my_method('tom', bad: true) }
          .to raise_error(ArgumentError)

        expect { subject.my_method('tom', 'hulihan.tom159@gmail.com', 'poop') }
          .to raise_error(ArgumentError)
      end
    end

    context 'when the correct number of arguments are passed' do
      let(:name) { 'tom' }
      let(:email) { 'hulihan.tom159@gmail.com' }
      let(:options) { { gender: 'male' } }
      let(:expected) {
        {
          method: 'post',
          path: 'test',
          query: options.merge(name: name, email: email)
        }
      }

      it 'makes the HTTP request' do
        expect(subject).to receive(:request).with(expected)

        subject.my_method(name, email, options)
      end

      it 'calls the block if given' do
        expect(subject).to receive(:request) { 1 }

        expect(subject.my_method(name, email, options, &:succ)).to eq(2)
      end
    end
  end

  describe '.mount' do
    subject { class_one.new(api_key) }
    let(:class_one) {
      Class.new(PlacesAPI::API).tap do |klass|
        klass.mount :class_two, class_two
      end
    }
    let(:class_two) { Class.new(PlacesAPI::API) }

    it 'mounts the sub-API' do
      expect(subject.class_two).to be_a(class_two)
    end
  end
end
