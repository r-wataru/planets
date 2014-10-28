# == Schema Information
#
# Table name: results
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  game_id           :integer          not null
#  plate_appearances :integer          default(0), not null
#  at_bats           :integer          default(0), not null
#  single_hits       :integer          default(0), not null
#  double_hits       :integer          default(0), not null
#  triple_hits       :integer          default(0), not null
#  home_run          :integer          default(0), not null
#  base_on_balls     :integer          default(0), not null
#  hit_by_pitches    :integer          default(0), not null
#  sacrifice_bunts   :integer          default(0), not null
#  sacrifice_flies   :integer          default(0), not null
#  gaffe             :integer          default(0), not null
#  infield_grounder  :integer          default(0), not null
#  outfield_grounder :integer          default(0), not null
#  infield_fly       :integer          default(0), not null
#  outfield_fly      :integer          default(0), not null
#  infield_linera    :integer          default(0), not null
#  out_linera        :integer          default(0), not null
#  strikeouts        :integer          default(0), not null
#  runs_batted_in    :integer          default(0), not null
#  runs_scored       :integer          default(0), not null
#  stolen_bases      :integer          default(0), not null
#  deleted_at        :datetime
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_results_on_user_id  (user_id)
#

require 'csv'
require "kconv"
require 'nkf'
class Result < ActiveRecord::Base
  belongs_to :game
  belongs_to :user
  
  attr_accessor :helper_member
  
  before_create do
    if self.user_id == 0
      u = User.create_helper_user(self.helper_member)
      self.user_id = u.id
    end
  end

  def total_hits
    self.single_hits.to_i + self.double_hits.to_i + self.triple_hits.to_i + self.home_run.to_i
  end

  def total_bases
    self.single_hits.to_i + self.double_hits.to_i * 2 + self.triple_hits.to_i * 3 + self.home_run.to_i * 4
  end

  class << self
    def import_csv
      path = Rails.root.join("db", "seeds", "data", "mla_export_p_batter.csv")
      if File.exists?(path)
        file = path.read
        data = NKF::nkf('-w', file)
        csv = CSV.new(data)
        csv.each_with_index do |arr, idx|
          data_arr = arr[0].split(";")
          if User.exists?(display_name: data_arr[2])
            user = User.find_by_display_name(data_arr[2])
            user.results.create(
              game_id: data_arr[0],
              plate_appearances: data_arr[3].to_i,
              at_bats: data_arr[4].to_i,
              single_hits: data_arr[5].to_i,
              double_hits: data_arr[6].to_i,
              triple_hits: data_arr[7].to_i,
              home_run: data_arr[8].to_i,
              base_on_balls: data_arr[9].to_i,
              hit_by_pitches: data_arr[10].to_i,
              sacrifice_bunts: data_arr[11].to_i,
              sacrifice_flies: data_arr[12].to_i,
              gaffe: data_arr[13].to_i,
              infield_grounder: data_arr[14].to_i,
              outfield_grounder: data_arr[15].to_i,
              infield_fly: data_arr[16].to_i,
              outfield_fly: data_arr[17].to_i,
              infield_linera: data_arr[18].to_i,
              out_linera: data_arr[19].to_i,
              strikeouts: data_arr[20].to_i,
              runs_batted_in: data_arr[21].to_i,
              runs_scored: data_arr[22].to_i,
              stolen_bases: data_arr[23].to_i)
          end
        end
      else
        return false
      end
    end
  end
end
