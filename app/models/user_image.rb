# == Schema Information
#
# Table name: user_images
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  data1         :binary
#  content_type1 :string(255)
#  data2         :binary
#  content_type2 :string(255)
#  data3         :binary
#  content_type3 :string(255)
#  data4         :binary
#  content_type4 :string(255)
#  data5         :binary
#  content_type5 :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_user_images_on_user_id  (user_id)
#

class UserImage < ActiveRecord::Base
end
