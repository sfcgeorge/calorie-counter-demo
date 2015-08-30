class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.integer :callories
      t.string :text
      t.date :date
      t.time :time

      t.timestamps null: false
    end
    add_index :meals, :date
    add_index :meals, :time
  end
end
