module Trooly
  class Configuration
    attr_accessor :use_mock, :clientid, :api_key, :opts

    def initialize(use_mock: false, clientid: nil, api_key: nil, opts: {})
      @use_mock = use_mock
      @clientid = clientid
      @api_key = api_key
      @opts = opts
    end
  end
end
