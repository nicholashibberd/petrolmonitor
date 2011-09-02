class PagesController < ApplicationController
  def home
    if current_user and current_user.group
      redirect_to new_group_journey_path(current_user.group)
    elsif current_user
      redirect_to user_path(current_user)
    else
      redirect_to signin_path
    end
  end

end
