class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
  end
  
  def create
    group = Group.new(params[:group])
    if group.save
      current_user.assign_group(group)      
      redirect_to group_path(group)
    else
      flash[:error] = "Error - Group did not save"
      render 'new'
    end  
  end

  def join
    @user = User.find(params[:user_id])
  end
  
  def join_new_group
    group = Group.find_by_group_token(params[:group_token])    
    current_user.assign_group(group)
    redirect_to group_path(group)
  end
  
end
