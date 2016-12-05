module Trooly
  class Client
    module Entity
      Evidence = struct_with(
        :type,
        :identity,
        :trooly_code,
        :synopsis
      )
    end
  end
end
