require 'trooly/client/response'
require 'trooly/client/parser/user'

require 'json'

module Trooly
  class Client
    class Resource
      class User < Resource
        include Response
        include Parser::User

        def find(userid)
          response = format_response( @web_driver.get("user/#{userid}") )

          handle_response(response) do
            data = JSON.parse(response.body)
            parse_user(data[userid], userid) unless response.body.nil?
          end
        end

        def submit(data)
          response = format_response( @web_driver.post('user', data.to_json) )

          handle_response(response) do
            true
          end
        end

      end
    end
  end
end
