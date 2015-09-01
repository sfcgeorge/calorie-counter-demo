require "forgery"

# This will guess the User class
FactoryGirl.define do
  factory :meal do
    user { create(:user) }
    calories { Forgery::Basic.number(at_least: 50, at_most: 2000) }
    text { Forgery::Basic.text }
    date { Forgery::Date.date }
    time { Time.now.strftime("%R") }
  end
end
