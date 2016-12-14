require 'trooly/client/entity/user'
require 'trooly/client/entity/trooly_code'
require 'trooly/client/entity/evidence'
require 'trooly/client/entity/synopsis'
require 'time'

module Trooly
  class Client
    module Parser
      module User
        def parse_user(user, userid)
          return nil if user.nil?

          user = deep_symbolize_keys(user)

          Entity::User.new(
            :userid => userid,
            :status => user[:status],
            :timestamp => parse_time(user[:timestamp]),
            :trooly_rating => user[:trooly_rating],
            :trooly_confidence => user[:trooly_confidence],
            :trooly_code => parse_trooly_codes(user[:trooly_code]),
            :evidence => parse_evidence(user[:evidence])
          )
        end

        private

        def parse_time(t)
          Time.parse(t) if t
        end

        def parse_trooly_codes(tc)
          return nil if tc.nil?

          tc.map do |code|
            Entity::TroolyCode.new(
              deep_symbolize_keys(code)
            )
          end
        end

        def parse_evidence(ev)
          return nil if ev.nil?

          ev.map do |e|
            Entity::Evidence.new(
              :type => e[:type],
              :identity => e[:identity],
              :trooly_code => parse_trooly_codes(e[:trooly_code]),
              :synopsis => parse_synopsis(e[:synopsis])
            )
          end
        end

        def parse_synopsis(syn)

          Entity::Synopsis.new(
            deep_symbolize_keys(syn)
          ) unless syn.nil?
        end

        def deep_symbolize_keys(element)
          return element.collect { |e| deep_symbolize_keys(e) } if element.is_a?(Array)
          return element.inject({}) { |sh,(k,v)| sh[k.to_sym] = deep_symbolize_keys(v); sh } if element.is_a?(Hash)
          element
        end
      end
    end
  end
end
