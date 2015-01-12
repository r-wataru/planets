class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :subject, null: false
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
