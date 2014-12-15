class PlanDetailsController < ApplicationController
  def show
    @plan = Plan.find_by(starts_on: params[:schedule_id])
    @plan_detail = @plan.plan_details.find(params[:id])
  end

  def new
    @plan = Plan.find_by(starts_on: params[:schedule_id])
    @plan_detail = @plan.plan_details.new
  end

  def create
    @plan = Plan.find(params[:schedule_id])
    @plan_detail = @plan.plan_details.new plan_detail_params
    if @plan_detail.save
      redirect_to schedule_plan_detail_path(id: @plan_detail.id, schedule_id: @plan.starts_on)
    else
      render action: :new
    end
  end

  def edit
    @plan = Plan.find(params[:schedule_id])
    @plan_detail = @plan.plan_details.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:schedule_id])
    @plan_detail = @plan.plan_details.find(params[:id])
    if @plan_detail.update_attributes plan_detail_params
      redirect_to schedule_plan_detail_path(schedule_id: @plan.starts_on, id: @plan_detail)
    else
      render action: :edit
    end
  end

  def add_or_delete
    if request.post?
      @plan = Plan.find(params[:schedule_id])
      @plan_detail = @plan.plan_details.find(params[:id])
      @user = User.find(params[:user])
      if params[:action_name] == "create"
        @plan_detail.user_plan_detail_links.create(user: @user, status: params[:status])
      elsif params[:action_name] == "delete"
        link = @plan_detail.user_plan_detail_links.find_by(user_id: @user, status: params[:status])
        link.destroy
      end
      render json: { user_id: @user.id, user_name: @user.display_name, status: params[:status] }
    else
      raise StandardError
    end
  end

  private
  def plan_detail_params
    params.require(:plan_detail).permit(
      :name, :description, :starts_on, :ends_on)
  end
end