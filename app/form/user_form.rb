class UserForm
  include ActiveModel::Model

  attr_accessor :user
  delegate :persisted?, to: :user

  def initialize(user = nil)
    @user = user
    @user ||= User.new
    @user.build_image unless @user.image
  end

  def assign_attributes(params = {})
    @params = params
    user.assign_attributes(user_params)
    if params[:image].present?
      user.image.assign_attributes(image_params)
      if params[:image][:uploaded_image_destroy].present? &&
          params[:image][:uploaded_image_destroy] == "1"
        user.image.data = nil
        user.image.content_type = nil
      end
      if params[:image][:uploaded_thumbnail_destroy].present? &&
          params[:image][:uploaded_thumbnail_destroy] == "1"
        user.image.thumbnail = nil
        user.image.thumbnail_content_type = nil
      end
    end
  end

  def save
    if user.valid? && user.image.valid?
      ActiveRecord::Base.transaction do
        user.save!
        user.image.save!
      end
    else
      false
    end
  end

  private
  def user_params
    @params.require(:user).permit(
      :number, :login_name, :display_name, :birthday,
      :description )
  end

  def image_params
    @params.require(:image).permit(
      :uploaded_image, :content_type, :uploaded_thumbnail,
      :thumbnail_content_type )
  end
end