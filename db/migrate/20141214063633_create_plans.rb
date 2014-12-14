class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.date :starts_on, null: false
      t.integer :plan_count, null: false, default: 0

      t.timestamps
    end
  end
end
