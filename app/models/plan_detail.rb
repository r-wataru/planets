# == Schema Information
#
# Table name: plan_details
#
#  id          :integer          not null, primary key
#  plan_id     :integer          not null
#  name        :string(255)      default(""), not null
#  description :text
#  starts_on   :time
#  ends_on     :time
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_plan_details_on_plan_id  (plan_id)
#

class PlanDetail < ActiveRecord::Base
  belongs_to :plan
  has_many :users, through: :user_plan_detail_links
  has_many :user_plan_detail_links

  validates :name, presence: true

  after_save do
    count = self.plan.plan_details.count
    self.plan.update_column(:plan_count, count)
  end
end
