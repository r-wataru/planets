class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :number
      t.string :login_name
      t.string :hashed_password
      t.string :display_name
      t.date :birthday
      t.integer :age
      t.datetime :logged_at
      t.text :description
      t.boolean :created, null: false, default: false
      t.boolean :checked, null: false, default: false
      t.datetime :deleted_at
      t.boolean :helper, null: false, default: false
      t.text :ability

      t.timestamps
    end
    add_index :users, :number, unique: true
  end
end