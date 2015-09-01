class MealSerializer < ActiveModel::Serializer
  attributes :id, :calories, :text, :date, :time
end
