class ApplicationController < ActionController::Base
  protect_from_forgery
  include UsersHelper
  
  def flash_display(error, message)
    case error
      when :amount then flash[:amount] = 'Please enter an amount for this fill up'
      when :description then flash[:description] = 'Please leave a description for this journey'
      when :user_ids then flash[:user_ids] = 'Please select some members'
      when :mileage then flash[:mileage] = 'You have a negative mileage!'
    end
  end
  
end
