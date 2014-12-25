class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, null: false
      t.string :title, null: false, default: ""
      t.text :description
      t.integer :number, null: false, default: 0
      t.boolean :possible, null: false, default: true
      t.boolean :result, null: false, default: false
      t.string :period
      t.boolean :gold, null: false, default: false

      t.timestamps
    end
  end
end
