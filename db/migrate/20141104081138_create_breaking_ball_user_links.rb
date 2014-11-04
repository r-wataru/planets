class CreateBreakingBallUserLinks < ActiveRecord::Migration
  def change
    create_table :breaking_ball_user_links do |t|
      t.integer :user_id, null: false
      t.integer :breaking_ball_id, null: false
      t.integer :level, null: false, default: 0

      t.timestamps
    end
  end
end
