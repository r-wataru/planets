class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :year, null: false
      t.string :name, null: false
      t.boolean :use, null: false, default: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :seasons, :year, unique: true
  end
end