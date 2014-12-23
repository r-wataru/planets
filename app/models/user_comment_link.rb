# == Schema Information
#
# Table name: user_comment_links
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  comment_id :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_user_comment_links_on_comment_id  (comment_id)
#  index_user_comment_links_on_user_id     (user_id)
#

class UserCommentLink < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
end
