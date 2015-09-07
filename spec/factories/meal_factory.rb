require "forgery"

ingredients = %w(chicken beef pork lamb duck prawn fish cheese bean tofu)
meals = %w(pasta salad pie tart pizza wrap bake calzone soup)

# This will guess the User class
FactoryGirl.define do
  factory :meal do
    user { create(:user) }
    calories { Forgery::Basic.number(at_least: 50, at_most: 2000) }
    text { "#{ingredients.sample.capitalize} #{meals.sample}" }
    date { Forgery::Date.date }
    time { "#{rand(0..23)}:#{rand(0..59)}" }
  end
end
