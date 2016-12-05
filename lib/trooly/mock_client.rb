module Trooly
  class MockClient
    attr_accessor :user

    def initialize
      @user = MockUser.new
    end

    class MockUser
      attr_accessor :found, :submission

      def initialize
        @found = @submission = nil
      end

      def find(userid)
        @found = userid
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

      def submit(user_submission)
        @submission = user_submission
        true
      end
    end
  end
end
