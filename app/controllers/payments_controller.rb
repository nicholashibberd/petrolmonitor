class PaymentsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @payment = @group.payments.new
  end

  def edit
    @group = Group.find(params[:group_id])    
    @payment = Payment.find(params[:id])
  end

  def index
  end
  
  def create
    payment = Payment.new(params[:payment])
    if payment.save
      group = Group.find(params[:payment][:group_id])
      redirect_to group_path(group)
    else
      flash[:error] = "Payment did not save"
      render 'new'
    end
  end
  
  def update
    payment = Payment.find(params[:id])
    if payment.update_attributes(params[:payment])
      group = Group.find(params[:payment][:group_id])
      redirect_to group_path(group)
    else
      flash[:error] = "Payment did not save"
      render 'edit'
    end
  end

end
