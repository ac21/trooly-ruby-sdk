require 'trooly/client/entity/user'
require 'trooly/client/entity/trooly_code'
require 'trooly/client/entity/evidence'
require 'trooly/client/entity/synopsis'
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
            :trooly_code => parse_trooly_codes(user['trooly_code']),
            :evidence => parse_evidence(user['evidence'])
          )
        end

        private

        def parse_time(t)
          Time.parse(t) if t
        end

        def parse_trooly_codes(tc)
          return nil if tc.nil?

          tc.map do |code|
            Entity::TroolyCode.new(code)
          end
        end

        def parse_evidence(ev)
          return nil if ev.nil?

          ev.map do |e|
            Entity::Evidence.new(
              :type => e['type'],
              :identity => e['identity'],
              :trooly_code => parse_trooly_codes(e['trooly_code']),
              :synopsis => parse_synopsis(e['synopsis'])
            )
          end
        end

        def parse_synopsis(syn)
          return nil if syn.nil?

          Entity::Synopsis.new(syn)

        end
      end
    end
  end
end
