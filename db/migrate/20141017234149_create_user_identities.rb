class CreateUserIdentities < ActiveRecord::Migration
  def change
    create_table :user_identities do |t|
      t.references :user, null: false
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :info, null: false
      
      t.timestamps
    end
    
    add_index :user_identities, [ :provider, :uid, :info ], unique: true
  end
end