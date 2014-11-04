# == Schema Information
#
# Table name: breaking_ball_user_links
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  breaking_ball_id :integer          not null
#  level            :integer          default(0), not null
#  created_at       :datetime
#  updated_at       :datetime
#

class BreakingBallUserLink < ActiveRecord::Base
  belongs_to :user
  belongs_to :breaking_ball
end
