# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  title       :string(255)      not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_posts_on_user_id_and_title  (user_id,title)
#

class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
end
