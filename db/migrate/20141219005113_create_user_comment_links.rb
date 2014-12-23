class CreateUserCommentLinks < ActiveRecord::Migration
  def change
    create_table :user_comment_links do |t|
      t.references :user, null: false
      t.references :comment, null: false

      t.timestamps
    end

    add_index :user_comment_links, :user_id
    add_index :user_comment_links, :comment_id
    add_foreign_key :user_comment_links, :comments
  end
end
