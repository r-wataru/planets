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

class Game < ActiveRecord::Base
end
