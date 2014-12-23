# == Schema Information
#
# Table name: comment_images
#
#  id           :integer          not null, primary key
#  comment_id   :integer          not null
#  data         :binary(214748364 not null
#  content_type :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_comment_images_on_comment_id  (comment_id)
#

class CommentImage < ActiveRecord::Base
  IMAGE_TYPES = { "image/jpeg" => "jpg", "image/gif" => "gif","image/png" => "png" }

  def extension
    IMAGE_TYPES[content_type]
  end

  def uploaded_image=(image)
    self.content_type = convert_content_type(image.content_type)
    self.data = image.read
    @uploaded_image = image
  end

  private
  def convert_content_type(ctype)
    ctype = ctype.rstrip.downcase
    case ctype
    when "image/pjpeg" then "image/jpeg"
    when "image/jpg"   then "image/jpeg"
    when "image/x-png" then "image/png"
    else ctype
    end
  end
end

