require 'rails_helper'

describe BarsService do
  after { Bar.destroy_all }

  describe '.all_bars' do
    let!(:bars) {
      10.times.map do |i|
        subject.create_bar(
          name: "Bar ##{i}",
          address: "#{i} Fake Street, Boston, MA",
          place_id: 27.times.map { rand(10) }.join
        )
      end
    }

    it 'returns a list of every bar' do
      expect(subject.all_bars).to eq(bars)
    end
  end

  describe '.get_bar' do
    let(:place_id) { 27.times.map { rand(10) }.join }

    context 'when the given place_id cannot be found' do
      it 'returns nil' do
        expect(subject.get_bar(place_id)).to be_nil
      end
    end

    context 'when the given place_id can be found' do
      let(:bar) {
        {
          'name' => "Bar",
          'address' => "#10 Fake Street, Boston, MA",
          'place_id' => place_id
        }
      }
      let(:found_bar) { subject.get_bar(place_id) }

      before { subject.create_bar(bar) }

      it 'returns the corresponding Bar' do
        expect(found_bar.tap { |bar| bar.delete('id') }).to eq(bar)
      end
    end
  end

  describe '.exists?' do
    let(:place_id) { 27.times.map { rand(10) }.join }
    subject { BarsService.exists?(place_id) }

    context 'when the given place_id has a corresponding Bar' do
      before do
        BarsService.create_bar(
          name: 'Some Bar',
          address: 'Some Address',
          place_id: place_id,
        )
      end

      it { should be_truthy }
    end

    context 'when the given place_id has a corresponding Bar' do
      it { should be_falsey }
    end
  end

  describe '.create_bar' do
    let(:name) { 'The Yard House' }
    let(:address) { '126 Brookline Ave, Boston, MA 02215' }
    let(:place_id) { 27.times.map { rand(10) }.join }

    let(:hash) {
      {
        'name' => name,
        'address' => address,
        'place_id' => place_id
      }
    }

    context 'when not enough information is given' do
      before { hash.delete('name') }
      after { hash['name'] = name }

      it 'raises an error' do
        expect { subject.create_bar(hash) }.to raise_error
      end
    end

    context 'when not enough information is given' do
      context 'when the given place_id is already in the database' do
        let(:other_hash) { hash.dup.tap { |h| h[:name] = 'Louie\'s' } }

        before { subject.create_bar(other_hash) }

        it 'raises an error' do
          expect { subject.create_bar(hash) }.to raise_error
        end
      end

      context 'when the given place_id is not already in the database' do
        it 'creates a new bar' do
          expect { subject.create_bar(hash) }
            .to change { subject.all_bars.length }
            .by(1)
        end

        it 'returns the bar\'s attributes' do
          expect(subject.create_bar(hash).tap { |h| h.delete('id') }).to eq(hash)
        end
      end
    end
  end

  describe '.destroy_bar' do
    let(:place_id) { 27.times.map { rand(10) }.join }

    context 'when the given place_id exists' do
      before do
        subject.create_bar(
          place_id: place_id,
          name: 'Name',
          address: 'Address'
        )
      end

      it 'destroys that bar' do
        expect { subject.destroy_bar(place_id) }
          .to change { subject.all_bars.length }
          .by(-1)
      end
    end

    context 'when the given place_id does not exist' do
      it 'does nothing' do
        expect { subject.destroy_bar(place_id) }
          .to_not change { subject.all_bars.length }
      end
    end
  end
end
