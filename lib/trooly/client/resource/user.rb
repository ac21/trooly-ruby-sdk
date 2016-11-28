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
            return nil if response.body.nil?

            user = parse_user(response.body, userid)
            user.userid = userid

            return user
          end
        end

        def submit(user_submission, callback = nil, callback_token = nil)
          data = { :user => compact(user_submission.to_h)}
          data[:callback] = callback unless callback.nil?
          data[:callback_token] = callback_token unless callback_token.nil?

          response = format_response( @web_driver.post('user', data.to_json) )

          handle_response(response) do
            true
          end
        end

        private

        def compact(hash)
          hash.select { |_, value| !value.nil? }
        end
      end
    end
  end
end
