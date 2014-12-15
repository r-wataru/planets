class CreateUserPlanDetailLinks < ActiveRecord::Migration
  def change
    create_table :user_plan_detail_links do |t|
      t.references :user, null: false
      t.references :plan_detail, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
