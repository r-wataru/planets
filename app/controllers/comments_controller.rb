class CommentsController < ApplicationController
  skip_before_filter :authenticate_user, only: [ :index, :create ]

  def index
    @post = Post.find(params[:post_id])
    if @post.publication?
      @comments = @post.comments.page(params[:page]).per(10)
      @comment = Comment.new
      @comment_form = CommentForm.new(@comment)
    else
      if current_user
        @comments = @post.comments.page(params[:page]).per(10)
        @comment = Comment.new
        @comment_form = CommentForm.new(@comment)
      else
        raise NotFound
      end
    end
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

  # Ajax Post
  def like_add_or_delete
    if request.post?
      comment = Comment.find(params[:like][:comment_id])
      user = User.find(params[:like][:user_id])
      if like = UserCommentLink.find_by(user: user, comment: comment)
        add = false
        like.destroy
      else
        add = true
        UserCommentLink.create(user: user, comment: comment)
      end
      render json: { add: add }
    else
      raise NotFound
    end
  end
end