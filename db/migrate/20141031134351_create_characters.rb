class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.text :description
      t.integer :condition, default: 0, null: false
      t.boolean :use_type, null: false, default: false

      t.timestamps
    end
  end
end
