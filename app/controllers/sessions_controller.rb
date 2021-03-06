class SessionsController < ApplicationController
  def new
  end

  def create
    # authenticate the user
    @user = User.find_by({ email: params["email"] })
    if @user
      if BCrypt::Password.new(@user.password) == params["password"]
        session[:user_id] = @user.id
        flash[:notice] = "Welcome"
        redirect_to "/places"
      else
        flash[:notice] = "Password or Username is incorrect. Please try Again!"
        redirect_to "/sessions/new"
      end
    else
      flash[:notice] = "Password or Username is incorrect. Please try Again!"
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out"
    redirect_to "/sessions/new"
  end
end
  