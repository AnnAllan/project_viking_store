class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user
      sign_in user
      flash[:success] = "You are now signed in"
      redirect_to root_path
    else
      flash.now[:error] = "Could not sign in user"
      render :new
    end
  end

  def destroy
    if sign_out
      flash[:success] = "You are now signed out"
      redirect_to root_path
    else
      flash[:error] = "Could not sign you out."
      redirect_to root_path
    end
  end
end
