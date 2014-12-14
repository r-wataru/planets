class CreatePlanDetails < ActiveRecord::Migration
  def change
    create_table :plan_details do |t|
      t.references :plan, null: false
      t.string :name, null: false, default: ""
      t.text :description
      t.time :starts_on
      t.time :ends_on

      t.timestamps
    end
    
    add_index :plan_details, [ :plan_id ]
    add_foreign_key :plan_details, :plans
  end
end
