require 'spec_helper'
require 'json'

describe Trooly::Client do
  let(:clientid) { "clientid" }
  let(:api_key) { "secret" }
  let(:opts) { {} }
  let(:web_driver_class) { class_double("Faraday").as_stubbed_const(transfer_nested_constants: true)  }
  let(:web_driver) { double(:web_driver, headers: {} )  }
  let(:client) { described_class.new(clientid, api_key) }

  before(:each) do
    allow(web_driver_class).to receive(:new).and_return( web_driver )
  end

  it 'has a version number' do
    expect(Trooly::Client::VERSION).not_to be nil
  end

  describe '#new' do
    subject { client }

    it { is_expected.to be_a(described_class) }

    context 'header Authorization' do
      let(:auth) { 'Basic Y2xpZW50aWQ6c2VjcmV0' }

      it 'is base64 encoding of clientid and api_key' do
        expect(client.web_driver.headers['Authorization']).to eq(auth)
      end
    end
  end

  describe 'user' do
    subject { client.user }
    it { is_expected.to be_a(Trooly::Client::Resource::User) }
  end

  describe '#verify' do
    let(:response) { double(:response, status: 200, headers: {}, body: "{\"success\": {\"code\": 200  } }" ) }
    subject { described_class.new(clientid, api_key).verify }

    before(:each) do
      allow(web_driver).to receive(:post).and_return(response)
    end

    it { is_expected.to eq(true) }

    context 'when status is not a success' do
      let(:response) { double(:response, status: 400, headers: {}, body: "{\"error\": {\"code\": 400  } }" ) }

      it 'is expected to raise an error' do
        expect{ subject }.to raise_error(Trooly::Client::Error::BadRequest)
      end
    end
  end
end
