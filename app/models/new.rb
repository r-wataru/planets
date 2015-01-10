# == Schema Information
#
# Table name: news
#
#  id             :integer          not null, primary key
#  vote_id        :integer
#  result_id      :integer
#  post_id        :integer
#  plan_id        :integer
#  plan_detail_id :integer
#  pitcher_id     :integer
#  game_id        :integer
#  comment_id     :integer
#  message        :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_news_on_comment_id      (comment_id)
#  index_news_on_game_id         (game_id)
#  index_news_on_pitcher_id      (pitcher_id)
#  index_news_on_plan_detail_id  (plan_detail_id)
#  index_news_on_plan_id         (plan_id)
#  index_news_on_post_id         (post_id)
#  index_news_on_result_id       (result_id)
#  index_news_on_vote_id         (vote_id)
#

class New < ActiveRecord::Base
  belongs_to :vote
  belongs_to :result
  belongs_to :post
  belongs_to :plan
  belongs_to :plan_detail
  belongs_to :pitcher
  belongs_to :game
  belongs_to :comment

  after_commit do
    AccountMailer.newspaper(self).deliver
  end

  def self.create_newspaper(data)
    n = self.new
    update_already = true
    case data.class.name
    when "Vote"
      n.vote = data
      n.message = "投票を更新しました。"
      update_already = self.exists?(vote_id: data.id,
        created_at: (Date.today.beginning_of_day..Date.today.end_of_day))
    when "Result"
      n.result = data
      n.message = "成績を更新しました。"
      update_already = self.exists?(vote_id: data.id,
        created_at: (Date.today.beginning_of_day..Date.today.end_of_day))
    when "Post"
      n.post = data
      n.message = "掲示板を更新しました。"
      update_already = self.exists?(post_id: data.id,
        created_at: (Date.today.beginning_of_day..Date.today.end_of_day))
    when "PlanDetail"
      n.plan_detail = data
      n.message = "予定を更新しました。"
      update_already = self.exists?(plan_detail_id: data.id,
        created_at: (Date.today.beginning_of_day..Date.today.end_of_day))
    when "Pitcher"
      n.pitcher = data
      n.message = "投手の成績を更新しました。"
      update_already = self.exists?(pitcher_id: data.id,
        created_at: (Date.today.beginning_of_day..Date.today.end_of_day))
    when "Game"
      n.game = data
      n.message = "試合結果を更新しました。"
      update_already = self.exists?(game_id: data.id,
        created_at: (Date.today.beginning_of_day..Date.today.end_of_day))
    when "Comment"
      n.comment = data
      n.message = "掲示板を更新しました。"
      update_already = self.exists?(comment_id: data.id,
        created_at: (Date.today.beginning_of_day..Date.today.end_of_day))
    else
      nil
    end
    unless update_already
      n.save
    end
  end
end
