module Trooly
  class Client
    module Entity
      Synopsis = struct_with(
        :name,
        :address,
        :dob,
        :offense,
        :handle,
        :category,
        :snippet,
        :snippet_id,
        :snippet_formats,
        :related_user_id
      )
    end
  end
end
