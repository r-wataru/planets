class CommentImagesController < ApplicationController
  def show
    @image = CommentImage.find(params[:id])
    send_data @image.data, type: @image.content_type, disposition: 'inline'
  end
end