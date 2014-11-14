class CreateUserImages < ActiveRecord::Migration
  def change
    create_table :user_images do |t|
      t.references :user, null: false
      t.binary :data, limit: 20.megabytes
      t.string :content_type
      t.binary :thumbnail, limit: 20.megabytes
      t.string :thumbnail_content_type

      t.timestamps
    end

    add_index :user_images, :user_id
  end
end