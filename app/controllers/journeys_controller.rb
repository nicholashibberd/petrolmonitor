class JourneysController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @journey = @group.journeys.new
  end

  def edit
    @group = Group.find(params[:group_id])    
    @journey = Journey.find(params[:id])    
  end

  def index
  end
  
  def create
    journey = Journey.new(params[:journey])
    if journey.save
      group = Group.find(params[:journey][:group_id])
      redirect_to group_path(group)
    else
      flash[:error] = "Journey did not save"
      render 'new'
    end
  end
  
  def update
    journey = Journey.find(params[:id])
    if journey.update_attributes(params[:journey])
      group = Group.find(params[:journey][:group_id])
      redirect_to group_path(group)
    else
      flash[:error] = "Journey did not save"
      render 'edit'
    end
  end

end
