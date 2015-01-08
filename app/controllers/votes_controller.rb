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
      redirect_to :votes
    else
      render action: :new
    end
  end

  def edit
    @vote = Vote.find(params[:id])
  end

  def update
    @vote = Vote.find(params[:id])
    if @vote.update_attributes vote_params
      redirect_to :votes
    else
      render action: :edit
    end
  end

  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    redirect_to :votes
  end

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
