class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :season, null: false
      t.string :name, null: false
      t.text :description
      t.datetime :played_at, null: false
      t.string :total_result, null: false
      t.integer :winning, null: false
      t.text :result1
      t.text :result2
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :games, :season_id
  end
end