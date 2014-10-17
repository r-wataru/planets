class CreateUserImages < ActiveRecord::Migration
  def change
    create_table :user_images do |t|
      t.references :user, null: false
      t.binary :data1
      t.string :content_type1
      t.binary :data2
      t.string :content_type2
      t.binary :data3
      t.string :content_type3
      t.binary :data4
      t.string :content_type4
      t.binary :data5
      t.string :content_type5

      t.timestamps
    end

    add_index :user_images, :user_id
  end
end