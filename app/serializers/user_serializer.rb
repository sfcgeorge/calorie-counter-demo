class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :target_calories, :admin
end
