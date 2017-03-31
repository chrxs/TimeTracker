class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :image, :is_admin
end
