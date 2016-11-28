module Trooly
  class Client
    class Resource
      def initialize(web_driver)
        @web_driver = web_driver
      end
    end
  end
end

# Load all resources
Dir[File.join(File.dirname(__FILE__), 'resource/*.rb')].each { |file| require file }
