class CreatePasswords < ActiveRecord::Migration
  def change
    create_table :passwords do |t|
      t.string :hashed_password

      t.timestamps
    end
  end
end
