require 'spec_helper'
require 'json'

class Trooly::Client::ResponseTest
  include Trooly::Client::Response

  def call_body(r)
    body(r)
  end

  def call_handle_response(r)
    handle_response(format_response(r)) do
      true
    end
  end
end

describe Trooly::Client::Response do
  let(:response) { double(:response, status: 201, headers:{}, body:"hello") }
  let(:tester) { Trooly::Client::ResponseTest.new }

  describe "#body" do
    subject { tester.call_body(response) }

    it { is_expected.to eq(response.body) }

    context 'when response.body == ""' do
      let(:response) { double(:response, status: 201, headers:{}, body:"") }
      it { is_expected.to eq(nil) }
    end
  end

  describe "#handle_response" do
    subject { tester.call_handle_response(response) }

    [
      [400, Trooly::Client::Error::BadRequest],
      [401, Trooly::Client::Error::Unauthorized],
      [403, Trooly::Client::Error::Forbidden],
      [404, Trooly::Client::Error::NotFound],
      [409, Trooly::Client::Error::Conflict],
      [410, Trooly::Client::Error::Gone],
      [500, Trooly::Client::Error::ServerError],
      [501, Trooly::Client::Error::Undefined]
    ].each do |elem|
      context "for error #{elem[0]}" do
        let(:response) { double(:response, status: elem[0], headers:{}, body: "") }

        it "raises an #{elem[1].name} error" do
          expect { subject}.to raise_error(elem[1])
        end
      end
    end
  end
end
