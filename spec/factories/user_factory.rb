require "forgery"

# This will guess the User class
FactoryGirl.define do
  factory :user do
    username { Forgery::Basic.text }
    password "Password1"
    admin false
    target_calories { Forgery::Basic.number(at_least: 100, at_most: 2000) }
  end
end
