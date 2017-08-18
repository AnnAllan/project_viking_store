class UsersController < ApplicationController
  def new
    @user = User.new
    2.times {@user.addresses.build}
  end

  def create
    @user = User.new(safe_params)
    if @user.save
      flash[:success] = "User created"
      sign_in(@user)
      redirect_to products_path
    else
      flash[:error] = "Could not create new user"
      render :new
    end
  end

  def edit
    @user = current_user
    @user.addresses.build
  end

  def update
    @user = current_user
    if @user.update(safe_params)
      flash[:success] = "Account updated."
      redirect_to products_path
    else
      flash.now[:error] = "Account could not be updated."
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    session[:return_to] ||=request.referer
    if @user.destroy && sign_out
      flash[:success] = "User deleted."
      redirect_to products_path
    else
      flash[:error] = "User could not be deleted."
      render :edit
    end
  end

  private

  def safe_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number, :billing_id, :shipping_id, {address_attributes: [:id, :user_id, :street_address, :city, :state_abbr, :zip_code]})
  end
end
