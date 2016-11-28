module Trooly
  class Client
    module Entity
      def self.struct_with(*args)
        Struct.new(*args) do
          def initialize(fields = {})
            super(*fields.values_at(*members))
          end
        end
      end
    end
  end
end

# Load all entities
Dir[File.join(File.dirname(__FILE__), 'entity/*.rb')].each { |file| require file }
