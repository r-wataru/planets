# == Schema Information
#
# Table name: comment_images
#
#  id           :integer          not null, primary key
#  comment_id   :integer          not null
#  data         :binary(214748364
#  content_type :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_comment_images_on_comment_id  (comment_id)
#

class CommentImage < ActiveRecord::Base
  belongs_to :comment

  validate :check_image

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

  def check_image
    if @uploaded_image
      if data.size > 5.megabytes
        errors.add(:uploaded_image, :too_big_image)
      end
      unless IMAGE_TYPES.has_key?(content_type)
        errors.add(:uploaded_image, :invalid_image)
      end
    end
  end
end

