require 'trooly/client/entity/user'
require 'json'

module Trooly
  class Client
    module Parser
      module User
        def parse_user(data, userid)

          user = JSON.parse(data)[userid]
          return nil if user.nil?

          Entity::User.new(
            :userid => userid,
            :status => user['status'],
            :timestamp => parse_time(user['timestamp']),
            :trooly_rating => user['trooly_rating'],
            :trooly_confidence => user['trooly_confidence'],
            :trooly_code => user['trooly_code'],
            :evidence => user['evidence']
          )
        end

        private

        def parse_time(t)
          Time.parse(t) if t
        end
      end
    end
  end
end
