class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      set_user_cookie @user
      redirect_to @user
    else
      flash[:error] = 'User did not save correctly: Please complete all fields'
      render 'new'
    end
  end
  
  def validate
    user = User.authenticate(params[:user][:email], params[:user][:password])
    if user.nil?
      flash[:success] = "Your email/password combination is invalid"
    redirect_to signin_path
    else
      set_user_cookie user
      redirect_to user
    end
  end
  
  def signout
    sign_out
    redirect_to signin_path
  end

end
