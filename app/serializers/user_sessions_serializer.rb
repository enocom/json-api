class UserSessionsSerializer < ActiveModel::Serializer
  self.root = false
  attributes :authentication_token
end
