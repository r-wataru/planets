class CommentImagesController < ApplicationController
  skip_before_filter :authenticate_user

  def show
    @image = CommentImage.find(params[:id])
    send_data @image.data, type: @image.content_type, disposition: 'inline'
  end
end