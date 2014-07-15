require 'rails_helper'

describe UsersService do
  after { User.destroy_all }

  describe '.all_users' do
    let(:new_users) do
      10.times.map { subject.create_user }.sort_by { |user| user['id'] }
    end
    let(:found_users) do
      subject.all_users.sort_by { |user| user['id'] }
    end

    it 'returns every User' do
      found_users.zip(new_users).each do |found, new|
        found.keys
          .reject { |key| %w(created_at updated_at).include?(key) }
          .each { |key| expect(found[key]).to eq(new[key]) }
      end
    end
  end

  describe '.get_user' do
    let(:user) { UsersService.create_user }

    context 'when the User exists' do
      subject { UsersService.get_user(user['session']) }

      it { should eq(user) }
    end

    context 'when the User does not exist' do
      subject { UsersService.get_user('lol') }

      it { should be_nil }
    end
  end

  describe '.exists?' do
    subject { UsersService.exists?(session) }

    context 'when the User exists' do
      let(:session) { UsersService.create_user['session'] }

      it { should be_truthy }
    end

    context 'when the User does not exist' do
      let(:session) { 'lol' }

      it { should be_falsey }
    end
  end

  describe '.create_user' do
    it 'creates a User' do
      expect { subject.create_user }
        .to change { subject.all_users.length }
        .by(1)
    end

    it 'returns a Hash' do
      expect(subject.create_user.keys).to eq(%w(id session))
    end
  end

  describe '.destroy_user' do
    let!(:session) { subject.create_user['session'] }

    it 'destroys a User' do
      expect { subject.destroy_user(session) }
        .to change { subject.all_users.length }
        .by(-1)
    end
  end
end
