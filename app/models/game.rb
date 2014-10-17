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

  attr_accessor :creating_game
end