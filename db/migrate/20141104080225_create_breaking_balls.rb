class CreateBreakingBalls < ActiveRecord::Migration
  def change
    create_table :breaking_balls do |t|
      t.string :name

      t.timestamps
    end
  end
end
