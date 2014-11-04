# == Schema Information
#
# Table name: breaking_balls
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class BreakingBall < ActiveRecord::Base
  has_many :breaking_ball_user_links
  has_many :users, through: :breaking_ball_user_links, source: :user
end
