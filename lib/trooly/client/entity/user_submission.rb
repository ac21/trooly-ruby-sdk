module Trooly
  class Client
    module Entity
      UserSubmission = struct_with(
        :userid,
        :names,
        :business_names,
        :phones,
        :emails,
        :dobs,
        :ip_addresses,
        :facebook_tokens,
        :addresses,
        :address_strings
      )
    end
  end
end
