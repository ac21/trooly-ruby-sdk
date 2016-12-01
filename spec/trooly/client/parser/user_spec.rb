require 'spec_helper'
require 'json'

class MockUserParser
  include Trooly::Client::Parser::User
end

describe MockUserParser do
  let(:userid) { "troolytest" }
  let(:trooly_code) {
    {
      "code": "traffic",
      "confidence": "low",
      "hierarchy": ["traffic", "minor_crime"]
    }
  }

  let(:evidence) {
    {
      "type": "database",
      "identity": "weak_match",
      "trooly_code": [trooly_code],
      "synopsis": {
        snippet: "missing_dob"
      }
    }
  }

  let(:data) {
    {
      "troolytest" => {
        "status" => "ready",
        "timestamp" => "2015-06-27T16:08:39.411000+00:00",
        "trooly_code" => [trooly_code],
        "evidence" => [evidence]
      }
    }.to_json
  }
  let(:parser) { described_class.new }

  describe '#parse_user' do
    subject { parser.parse_user(data, userid) }

    it { is_expected.to be_a(Trooly::Client::Entity::User) }

    it 'has correct properties' do
      expect(subject.trooly_code).to be_a(Array)
      expect(subject.trooly_code.first).to be_a(Trooly::Client::Entity::TroolyCode)
      expect(subject.evidence).to be_a(Array)
      expect(subject.evidence.first).to be_a(Trooly::Client::Entity::Evidence)
      expect(subject.evidence.first.synopsis).to be_a(Trooly::Client::Entity::Synopsis)
    end
  end
end
