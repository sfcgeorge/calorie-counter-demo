class RenameTargetCalloriesToTargetCaloriesInUser < ActiveRecord::Migration
  def change
    rename_column :users, :target_callories, :target_calories
  end
end
