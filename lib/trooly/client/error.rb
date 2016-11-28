module Trooly
  class Client
    class Error
      class BadRequest < StandardError; end
      class Unauthorized < StandardError; end
      class Forbidden < StandardError; end
      class NotFound < StandardError; end
      class Conflict < StandardError; end
      class Gone < StandardError; end
      class ServerError < StandardError; end
      class Undefined < StandardError; end
    end
  end
end
