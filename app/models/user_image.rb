# == Schema Information
#
# Table name: user_images
#
#  id                     :integer          not null, primary key
#  user_id                :integer          not null
#  data                   :binary
#  content_type           :string(255)
#  thumbnail              :binary
#  thumbnail_content_type :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_user_images_on_user_id  (user_id)
#

class UserImage < ActiveRecord::Base
  belongs_to :user

  attr_reader :uploaded_image
  attr_reader :uploaded_thumbnail
  attr_accessor :uploaded_thumbnail_destroy, :uploaded_image_destroy
  validate :check_image
  validate :check_thumbnail

  IMAGE_WIDTH = 1024
  IMAGE_HEIGHT = 315
  THUMBNAIL_WIDTH = 100
  THUMBNAIL_HEIGHT = 100
  IMAGE_TYPES = { "image/jpeg" => "jpg", "image/gif" => "gif","image/png" => "png" }

  before_save do
    # Coverのカット
    if data_changed? and !data.nil?
      image = Magick::Image.from_blob(data).first.resize_to_fill(IMAGE_WIDTH, IMAGE_HEIGHT, Magick::CenterGravity)
      self.data = image.to_blob
    end
    # Thumbnailのカット
    if thumbnail_changed? and !thumbnail.nil?
      thumbnail_image = Magick::Image.from_blob(thumbnail).first.resize_to_fill(THUMBNAIL_WIDTH, THUMBNAIL_HEIGHT)
      self.thumbnail = thumbnail_image.to_blob
    end
  end

  def extension
    IMAGE_TYPES[content_type]
  end

  def thumbnail_extension
    IMAGE_TYPES[thumbnail_content_type]
  end

  def uploaded_image=(image)
    self.content_type = convert_content_type(image.content_type)
    self.data = image.read
    @uploaded_image = image
  end

  def uploaded_thumbnail=(thumbnail_image)
    self.thumbnail_content_type = convert_content_type(thumbnail_image.content_type)
    self.thumbnail = thumbnail_image.read
    @uploaded_thumbnail = thumbnail_image
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

  def check_thumbnail
    if @uploaded_thumbnail
      if thumbnail.size > 2.megabytes
        errors.add(:uploaded_thumbnail, :too_big_image)
      end
      unless IMAGE_TYPES.has_key?(thumbnail_content_type)
        errors.add(:uploaded_thumbnail, :invalid_image)
      end
    end
  end

  def check_image
    if @uploaded_image
      if data.size > 2.megabytes
        errors.add(:uploaded_image, :too_big_image)
      end
      unless IMAGE_TYPES.has_key?(content_type)
        errors.add(:uploaded_image, :invalid_image)
      end
    end
  end
end
