class MealSerializer < ActiveModel::Serializer
  attributes :id, :calories, :text, :date, :time

  def time
    object.time.strftime("%H:%M")
  end
end
