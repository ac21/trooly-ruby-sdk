module Trooly
  class Client
    module Entity
      TroolyCode = struct_with(
        :code,
        :confidence,
        :hierarchy
      )
    end
  end
end
