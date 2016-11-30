require 'trooly/client'
require 'trooly/configuration'
require 'trooly/mock_client'

module Trooly
  class << self

    def client
      trooly_client
    end

    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    private

    def trooly_client
      @trooly_client ||= if configuration.use_mock
        MockClient.new
      else
        Client.new(
          configuration.clientid,
          configuration.api_key
        )
      end
    end
  end
end
