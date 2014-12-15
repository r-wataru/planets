# == Schema Information
#
# Table name: user_plan_detail_links
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  plan_detail_id :integer          not null
#  status         :integer          default(0), not null
#  created_at     :datetime
#  updated_at     :datetime
#

class UserPlanDetailLink < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan_detail
end
