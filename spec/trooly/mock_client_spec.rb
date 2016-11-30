require 'spec_helper'

describe Trooly::MockClient do
  let(:client) { described_class.new }

  describe'#new' do
    subject { client }
    it { is_expected.to be_a(described_class) }
  end
end

describe Trooly::MockClient::MockUser do
  let(:userid) { 'troolytest' }
  let(:user) { described_class.new }

  describe '#new' do
    subject { user }

    it { is_expected.to be_a(described_class) }
  end

  describe 'find' do
    subject { user.find(userid) }

    it { is_expected.to be_a(Trooly::Client::Entity::User) }
  end

  describe '#submit' do
    let(:data) { {
      :user => {
        :userid => userid,
        :names => ['John Smith'],
        :emails => ['j.smith@example.org', 'john@example.org']
      }
    } }
    subject { user.submit(data) }

    it { is_expected.to eq(true) }
  end
end
