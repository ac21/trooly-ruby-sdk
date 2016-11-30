module Trooly
  class MockClient
    attr_accessor :user

    def initialize
      @user = MockUser.new
    end

    class MockUser
      def find(userid)
        Trooly::Client::Entity::User.new(
          userid: userid,
          status: 'ready',
          timestamp: Time.now,
          trooly_rating: 1,
          trooly_confidence: 'high',
          trooly_code: [],
          evidence: []
        )
      end

      def submit(_user_submission)
        true
      end
    end
  end
end
