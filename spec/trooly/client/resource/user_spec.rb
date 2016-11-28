require 'spec_helper'
require 'json'

describe Trooly::Client::Resource::User do
  let(:web_driver) { double(:web_driver, headers: {}, get: get_response, post: post_response)  }
  let(:userid) { 'troolytest' }
  let(:user) { described_class.new(web_driver) }

  let(:get_response) {
    double(:get_response,
      status: 200,
      headers: {},
      body: {
        "troolytest": {
          "status": "ready",
          "timestamp": "2015-06-27T16:08:39.411000+00:00"
        }
      }.to_json
    )
  }

  let(:post_response) {
    double(:response,
      status: 200,
      headers: {},
      body: { "success": { "code": 200 } }.to_json
    )
  }

  describe '#new' do
    subject { user }

    it { is_expected.to be_a(described_class) }
  end

  describe 'find' do
    subject { user.find(userid) }

    it { is_expected.to be_a(Trooly::Client::Entity::User) }
  end

  describe '#submit' do
    let(:user_submission) {
      Trooly::Client::Entity::UserSubmission.new(
        :userid => userid,
        :names => ['John Smith'],
        :emails => ['j.smith@example.org', 'john@example.org']
      )
    }
    subject { user.submit(user_submission) }

    it { is_expected.to eq(true) }

    context 'when status is not a success' do
      let(:post_response) {
        double(:response,
          status: 400,
          headers: {},
          body: { "error": { "code": 400 } }.to_json
        )
      }

      it 'is expected to raise an error' do
        expect{ subject }.to raise_error(Trooly::Client::Error::BadRequest)
      end
    end
  end
end
