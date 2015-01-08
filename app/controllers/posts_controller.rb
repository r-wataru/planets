class PostsController < ApplicationController
  skip_before_filter :authenticate_user, only: [ :index ]

  def index
    @posts = Post.all
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new post_params
    if @post.save
      redirect_to [ @post, :comments ]
    else
      render action: :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes post_params
      redirect_to [ @post, :comments ]
    else
      render action: :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to :posts
  end

  private
  def post_params
    params.require(:post).permit(
      :title, :description, :publication)
  end
end
