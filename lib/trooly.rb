require 'trooly/client'
require 'trooly/version'
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
      configuration.use_mock ? mock_client : real_client
    end

    def mock_client
      @mock_client ||= MockClient.new
    end

    def real_client
      @real_client ||= Client.new(
        configuration.clientid,
        configuration.api_key,
        configuration.opts
      )
    end
  end
end
