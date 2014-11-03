class CreateCharacterUserLinks < ActiveRecord::Migration
  def change
    create_table :character_user_links do |t|
      t.integer :user_id, null: false
      t.integer :character_id, null: false

      t.timestamps
    end
  end
end
