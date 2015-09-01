class Meal < ActiveRecord::Base
  validates :calories, presence: true, numericality: {
    only_integer: true, less_than_or_equal_to: 30_000
  }
  validates :text, presence: true, length: { maximum: 200 }
  validates :date, presence: true
  validates :time, presence: true
end
