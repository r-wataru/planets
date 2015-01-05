# == Schema Information
#
# Table name: votes
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  title       :string(255)      default(""), not null
#  description :text
#  number      :integer          default(0), not null
#  possible    :boolean          default(TRUE), not null
#  result      :boolean          default(FALSE), not null
#  period      :string(255)
#  gold        :boolean          default(FALSE), not null
#  created_at  :datetime
#  updated_at  :datetime
#

# cron側 末日に行う
# model側 4ヶ月毎の末尾かどうか？
# 0 0 28-31 * * cd /var/rails/planets_production/current/; bin/rails runner -e production "Vote.vote_result_update"
# order number DESCで一番大きい者をgoldにする

class Vote < ActiveRecord::Base
  belongs_to :user

  scope :active, ->{ where(possible: true) }
  scope :not_active, -> { where(possible: false, gold: true, result: true)}

  validates :title, presence: true

  def period_value
    if Vote.kind_period[:h_start] < created_at && created_at < Vote.kind_period[:h_end]
      period = Date.new(Time.now.year, 1,1).strftime("%Y月%m日") + "~" + Date.new(Time.now.year, 4,1).strftime("%Y月%m日")
    elsif Vote.kind_period[:n_start] < created_at && created_at < Vote.kind_period[:n_end]
      period = Date.new(Time.now.year, 5,1).strftime("%Y月%m日") + "~" + Date.new(Time.now.year, 8,1).strftime("%Y月%m日")
    elsif Vote.kind_period[:a_start] < created_at && created_at < Vote.kind_period[:a_end]
      period = Date.new(Time.now.year, 9,1).strftime("%Y月%m日") + "~" + Date.new(Time.now.year, 12,1).strftime("%Y月%m日")
    else
    end
    return period
  end

  class << self
    def vote_result_can_update?
      case Date.today
      when Date.new(Time.now.year, 4,1).end_of_month
        true
      when Date.new(Time.now.year, 8,1).end_of_month
        true
      when Date.new(Time.now.year, 12,1).end_of_month
        true
      else
        false
      end
    end

    def vote_result_update
      if self.vote_result_can_update?
        Vote.active.order("number DESC").each_with_index do |vote, idx|
          vote.gold = true if idx == 0
          vote.period = vote.period_value
          vote.result = true
          vote.possible = false
          vote.save
        end
      end
    end

    def kind_period
      h = {}
      h[:h_start] = Date.new(Time.now.year, 1,1)
      h[:h_end] = Date.new(Time.now.year, 4,1).end_of_month
      h[:n_start] = Date.new(Time.now.year, 5,1)
      h[:n_end] = Date.new(Time.now.year, 8,1).end_of_month
      h[:a_start] = Date.new(Time.now.year, 9,1)
      h[:a_end] = Date.new(Time.now.year, 12,1).end_of_month
      return h
    end
  end
end