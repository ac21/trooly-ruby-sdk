module Trooly
  class Client
    class Resource
      def initialize(web_driver)
        @web_driver = web_driver
      end

      protected

      def resource_name
        self.class.name.to_s.split('::').last
      end

    end
  end
end

# Load all resources
Dir[File.join(File.dirname(__FILE__), 'resource/*.rb')].each { |file| require file }
