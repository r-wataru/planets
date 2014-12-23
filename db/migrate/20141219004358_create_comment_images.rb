class CreateCommentImages < ActiveRecord::Migration
  def change
    create_table :comment_images do |t|
      t.references :comment, null: false
      t.binary :data, null: false, limit: 20.megabytes
      t.string :content_type, null: false

      t.timestamps
    end
    
    add_index :comment_images, :comment_id
    add_foreign_key :comment_images, :comments
  end
end
