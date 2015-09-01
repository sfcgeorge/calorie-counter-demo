class AddUserToMeals < ActiveRecord::Migration
  def change
    add_reference :meals, :user, index: true, foreign_key: true
  end
end
