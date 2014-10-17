class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :user, null: false
      t.references :game, null: false
      t.integer :plate_appearances, null: false, default: 0   # 打席数
      t.integer :at_bats, null: false, default: 0             # 打数
      t.integer :single_hits, null: false, default: 0         # シングルヒット
      t.integer :double_hits, null: false, default: 0         # ２ベース
      t.integer :triple_hits, null: false, default: 0         # ３ベース
      t.integer :home_run, null: false, default: 0            # ホームラン
      t.integer :base_on_balls	, null: false, default: 0     # 四球
      t.integer :hit_by_pitches	, null: false, default: 0     # 死球
      t.integer :sacrifice_bunts, null: false, default: 0     # 犠打
      t.integer :sacrifice_flies, null: false, default: 0     # 犠飛
      t.integer :gaffe, null: false, default: 0               # 失策
      t.integer :infield_grounder, null: false, default: 0    # 内野ゴロ
      t.integer :outfield_grounder, null: false, default: 0   # 外野ゴロ
      t.integer :infield_fly, null: false, default: 0         # 内野フライ
      t.integer :outfield_fly, null: false, default: 0        # 外野フライ
      t.integer :infield_linera, null: false, default: 0      # 内野ライナー
      t.integer :out_linera, null: false, default: 0          # 外野ライナー
      t.integer :strikeouts, null: false, default: 0          # 三振
      t.integer :runs_batted_in, null: false, default: 0      # 打点
      t.integer :runs_scored, null: false, default: 0         # 得点
      t.integer :stolen_bases, null: false, default: 0        # 盗塁
      t.datetime :deleted_at
      
      t.timestamps
    end
    
    add_index :results, :user_id
  end
end