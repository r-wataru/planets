class PlanDetailsController < ApplicationController
  def show
    @plan = Plan.find_by(starts_on: params[:schedule_id])
    @plan_detail = @plan.plan_details.find(params[:id])
  end
end