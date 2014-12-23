class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, null: false
      t.string :title, null: false
      t.text :description

      t.timestamps
    end

    add_index :posts, [ :user_id, :title ]
    add_foreign_key :posts, :users
  end
end