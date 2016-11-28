module Trooly
  class Client
    module Entity
      User = struct_with(
        :userid,
        :status,
        :timestamp,
        :trooly_rating,
        :trooly_confidence,
        :trooly_code,
        :evidence
      )
    end
  end
end
