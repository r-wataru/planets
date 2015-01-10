class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.references :vote
      t.references :result
      t.references :post
      t.references :plan
      t.references :plan_detail
      t.references :pitcher
      t.references :game
      t.references :comment
      t.string :message

      t.timestamps null: false
    end

    add_index :news, :vote_id
    add_index :news, :result_id
    add_index :news, :post_id
    add_index :news, :plan_id
    add_index :news, :plan_detail_id
    add_index :news, :pitcher_id
    add_index :news, :game_id
    add_index :news, :comment_id
    add_foreign_key :news, :votes
    add_foreign_key :news, :results
    add_foreign_key :news, :posts
    add_foreign_key :news, :plans
    add_foreign_key :news, :plan_details
    add_foreign_key :news, :pitchers
    add_foreign_key :news, :games
    add_foreign_key :news, :comments
  end
end
