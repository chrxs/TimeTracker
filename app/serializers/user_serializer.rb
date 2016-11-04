class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :google_id
end
