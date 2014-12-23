class CommentForm
  include ActiveModel::Model

  attr_accessor :comment
  delegate :persisted?, to: :comment

  def initialize(comment = nil)
    @comment = comment
    @comment ||= Comment.new
    @comment.build_image unless @comment.image
  end

  def assign_attributes(params = {})
    @params = params
    comment.assign_attributes(comment_params)
    comment.image.assign_attributes(image_params) if params[:image]
    if params[:image] &&
      params[:image][:uploaded_image_destroy].present? &&
        params[:image][:uploaded_image_destroy] == "1"
      comment.image.data = nil
      comment.image.content_type = nil
    end
  end

  def save
    if comment.valid? && comment.image.valid?
      ActiveRecord::Base.transaction do
        comment.save!
        comment.image.save!
      end
    else
      false
    end
  end

  private
  def comment_params
    @params.require(:comment).permit(:comment)
  end

  def image_params
    @params.require(:image).permit(:uploaded_image, :content_type)
  end
end