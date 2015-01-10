# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  starts_on  :date             not null
#  plan_count :integer          default(0), not null
#  created_at :datetime
#  updated_at :datetime
#

class Plan < ActiveRecord::Base
  include AfterNewspaper

  has_many :plan_details
end
