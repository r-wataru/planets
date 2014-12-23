class CommentsController < ApplicationController
  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @comment = Comment.new
    @comment_form = CommentForm.new(@comment)
  end

  def create_image
    @post = Post.find(params[:post_id])
    raise # test用
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
    @comment.user_id = current_user ? current_user.id : 0
    @comment_form = CommentForm.new(@comment)
    @comment_form.assign_attributes(params[:comment_form])
    if @comment_form.save
      redirect_to [ @post, :comments ]
    else
      render action: :index
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to [ @post, :comments ]
  end
end