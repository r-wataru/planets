class CreateUserTokens < ActiveRecord::Migration
  def change
    create_table :user_tokens do |t|
      t.references :user, null: false
      t.references :email, null: false
      t.string :value
      t.boolean :used, default: false, null: false

      t.timestamps
    end
  end
end
