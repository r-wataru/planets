class InquiriesController < ApplicationController
  skip_before_filter :authenticate_user, only: [ :new, :create ]

  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new inquiry_params
    if @inquiry.save
      flash.notice = "受け付けました。"
      redirect_to :thanks_inquiries
    else
      flash.now.alert = "入力に誤りがあります。"
      render action: :new
    end
  end

  def thanks
  end

  def index
    @inquiries = Inquiry.order("id DESC")
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(
      :subject, :body, :email, :name)
  end
end