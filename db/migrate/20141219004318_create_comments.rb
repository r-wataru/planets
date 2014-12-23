class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post, null: false
      t.references :user, null: false
      t.text :comment
      t.integer :number

      t.timestamps
    end

    add_foreign_key :comments, :posts
    add_index :comments, :post_id
    add_index :comments, :user_id
  end
end
