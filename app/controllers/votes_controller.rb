class VotesController < ApplicationController
  skip_before_filter :authenticate_user, only: [ :index, :update_count ]

  def index
    @votes = Vote.active
    @past_votes = Vote.not_active
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = current_user.votes.new vote_params
    if @vote.save
      flash.notice = "作成しました。"
      redirect_to :votes
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: :new
    end
  end

  def edit
    @vote = Vote.find(params[:id])
  end

  def update
    @vote = Vote.find(params[:id])
    if @vote.update_attributes vote_params
      flash.notice = "更新しました。"
      redirect_to :votes
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: :edit
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    flash.notice = "削除しました。"
    redirect_to :votes
  end

  # Ajax PUT
  def update_count
    @vote = Vote.find(params[:id])
    @vote.number = params[:vote][:number]
    @vote.save
    render json: { num: @vote.number }
  end

  private
  def vote_params
    params.require(:vote).permit(
      :title, :description)
  end
end
