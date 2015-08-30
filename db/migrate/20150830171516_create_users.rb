class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :token
      t.boolean :admin
      t.integer :target_callories

      t.timestamps null: false
    end
    add_index :users, :username, unique: true
    add_index :users, :token, unique: true
  end
end
