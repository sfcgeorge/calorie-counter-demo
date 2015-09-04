class Meal < ActiveRecord::Base
  belongs_to :user

  validates :calories, presence: true, numericality: {
    only_integer: true, less_than_or_equal_to: 30_000
  }
  validates :text, presence: true, length: { maximum: 200 }
  validates :date, presence: true
  validates :time, presence: true

  def time=(time)
    self[:time] = self.class.time_to_int(time) if time
  end

  def time
    Time.at(self[:time].to_i) if self[:time]
  end

  def self.time_to_int(time)
    DateTime.strptime(time, "%H:%M").to_time.to_i if time
  end

  def self.time_between(from, to)
    if !from.blank? && !to.blank?
      where time: time_to_int(from)..time_to_int(to)
    else
      all
    end
  end

  def self.date_between(from, to)
    if !from.blank? && !to.blank?
      where date: from..to
    else
      all
    end
  end
end
