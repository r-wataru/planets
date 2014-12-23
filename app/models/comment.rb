# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  comment    :text
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  comments_post_id_fk  (post_id)
#

class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_one :image, class_name: "CommentImage", dependent: :destroy
end
