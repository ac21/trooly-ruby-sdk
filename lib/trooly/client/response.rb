require 'trooly/client/error'

module Trooly
  class Client
    module Response
      ClientResponse = Struct.new(:code, :headers, :body)

      def format_response(response)
        ClientResponse.new(
          response.status,
          response.headers,
          body(response)
        )
      end

      private

      def body(response)
        unless response.body.nil? || response.body.empty?
          response.body
        end
      end

      def handle_response(r, &block)
        case r.code
          when (200..399)
            yield
          when 400
            raise Error::BadRequest.new(r.body)
          when 401
            raise Error::Unauthorized.new(r.body)
          when 403
            raise Error::Forbidden.new(r.body)
          when 404
            raise Error::NotFound.new(r.body)
          when 409
            raise Error::Conflict.new(r.body)
          when 410
            raise Error::Gone.new(r.body)
          when 500
            raise Error::ServerError.new(r.body)
          else
            raise Error::Undefined.new(r.body)
        end
      end
    end
  end
end
