require 'trooly/client/entity'
require 'trooly/client/response'
require 'trooly/client/resource'

require "faraday"
require "logger"
require "base64"

module Trooly
  class Client
    include Response

    URL = 'https://api.troo.ly'
    API_VERSION = "1.0"

    attr_reader :web_driver

    DEFAULT_OPTIONS = {
      logger: ::Logger.new(STDOUT),
      logging: {
        bodies: false,
        headers: false
      }
    }

    def initialize(clientid, api_key, opts = {})
      @opts = DEFAULT_OPTIONS.merge(opts)

      @web_driver = ::Faraday.new([URL, API_VERSION].join("/")) do |faraday|
        faraday.response(:logger, @opts[:logger], @opts[:logging]) if @opts[:logger]
        faraday.adapter ::Faraday.default_adapter
      end

      @web_driver.headers['Authorization'] = create_authorization(clientid, api_key)
      @web_driver.headers['Content-Type'] = opts[:content_type] || 'application/json'
    end

    def user
      @user ||= Resource::User.new(@web_driver)
    end

    def verify
      user.submit( user: { userid: 'troolytest' } )
    end

    private

    def create_authorization(clientid, api_key)
      auth_str = Base64.strict_encode64([clientid, api_key].join(':'))
      "Basic #{auth_str}"
    end
  end
end
