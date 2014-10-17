class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :user, null: false
      t.string :address, null: false
      t.boolean :main, null: false, default: false
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :emails, :address, unique: true
  end
end