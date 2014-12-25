# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  user_id    :integer          not null
#  comment    :text
#  number     :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_one :image, class_name: "CommentImage", dependent: :destroy
  has_many :user_comment_links
end
