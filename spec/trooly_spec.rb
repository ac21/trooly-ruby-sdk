require 'spec_helper'

describe Trooly do
  let(:use_mock) { true }
  let(:api_key) { 'api_key' }
  let(:clientid) { 'clientid' }

  before(:each) do
    Trooly.configure do |c|
      c.use_mock = use_mock
      c.clientid = clientid
      c.api_key = api_key
    end
  end

  it 'has a semantic version number' do
    expect(Trooly::VERSION).to be_a(String)
    expect(Trooly::VERSION).to match(/\d*\.\d*\.\d*/)
  end

  describe 'class#client' do
    subject { described_class.client }

    context 'when use_mock == true' do
      let(:use_mock) { true }
      it { is_expected.to be_a(Trooly::MockClient) }
    end

    context 'when use_mock == false' do
      let(:use_mock) { false }

      it 'creates a client using the configuration clientid and api_key' do
        expect(Trooly::Client).to receive(:new).with(clientid, api_key).and_call_original
        expect(subject).to be_a(Trooly::Client)
      end
    end
  end

  describe 'class#configuration' do
    subject { described_class.configuration }

    it { is_expected.to be_a(Trooly::Configuration) }
  end

  describe 'class#configure' do
    it 'yields control with configuration' do
      expect { |b| described_class.configure(&b) }.to yield_with_args(Trooly::Configuration)
    end
  end
end
