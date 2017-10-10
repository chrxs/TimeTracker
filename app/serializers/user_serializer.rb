class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :image, :is_admin

  has_one :team
end
