# == Schema Information
#
# Table name: games
#
#  id           :integer          not null, primary key
#  season_id    :integer          not null
#  name         :string(255)      not null
#  description  :text
#  played_at    :datetime         not null
#  total_result :string(255)      not null
#  winning      :integer          not null
#  result1      :text
#  result2      :text
#  deleted_at   :datetime
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_games_on_season_id  (season_id)
#
require 'csv'
require "kconv"
require 'nkf'
class Game < ActiveRecord::Base
  belongs_to :season
  has_many :results
  has_many :pitchers

  scope :active, ->{ where(deleted_at: nil) }

  store :result1, accessors: [ :top, :one, :two, :three, :four, :five, :six, :seven, :eight, :nine, :total ]
  store :result2, accessors: [ :bottom, :one_2, :two_2, :three_2, :four_2, :five_2, :six_2, :seven_2, :eight_2, :nine_2, :total_2 ]

  def display_winning
    display = ""
    if self.winning == 0
      display = "勝ち"
    elsif self.winning == 1
      display = "負け"
    else
      display = "引き分け"
    end
    return display
  end

  def total_update(result)
    self.pitching_number = self.pitching_number.to_i + result.pitching_number.to_i
    self.hit = self.hit.to_i + result.hit.to_i
    self.run = self.run.to_i + result.run.to_i
    self.get_strikeouts = self.get_strikeouts.to_i + result.strikeouts.to_i
    self.save
  end

  class << self
    def import_csv
      path = Rails.root.join("db", "seeds", "data", "mla_export_p_game.csv")
      if File.exists?(path)
        file = path.read
        data = NKF::nkf('-w', file)
        csv = CSV.new(data)
        csv.each_with_index do |arr, idx|
          data_arr = arr[0].split(";")
          if data_arr[1].present? && Season.exists?(year: data_arr[32])
            date = data_arr[1].unpack("a4a2a2")
            date = Date.new(date[0].to_i, date[1].to_i,date[2].to_i)
            season = Season.find_by_year(data_arr[32])
            season.games.create(
              name: data_arr[2],
              description: data_arr[5],
              played_at: date,
              total_result: data_arr[4],
              winning: data_arr[3])
          end
        end
      else
        return false
      end
    end
  end
end