class RenameCalloriesToCaloriesInMeal < ActiveRecord::Migration
  def change
    rename_column :meals, :callories, :calories
  end
end
