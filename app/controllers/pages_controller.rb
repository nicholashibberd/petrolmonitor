class PagesController < ApplicationController
  def home
    if current_user and current_user.group and current_user.has_incomplete_journey?
      redirect_to edit_group_journey_path(current_user.group, :id => current_user.latest_incomplete_journey.id)
    elsif current_user and current_user.group
      redirect_to new_group_journey_path(current_user.group)
    elsif current_user
      redirect_to user_path(current_user)
    else
      redirect_to signin_path
    end
  end

end
