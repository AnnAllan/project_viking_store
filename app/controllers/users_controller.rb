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
      set_defaults
      flash[:success] = "Account updated."
      redirect_to products_path
    else
      flash.now[:error] = "Account could not be updated."
      render :edit
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
      check_cities
      params.require(:user).permit(:email, :first_name, :last_name, :phone_number, {address_attributes: [:id, :user_id, :street_address, :city_id, :state_id, :zip_code, :_destroy]})
    end

    def check_cities
      addresses = params[:user][:address_attributes]
      address_keys = addresses.keys
      address_keys.each do |key|
        next if addresses[key][:city_id]== ""
        addresses[key][:city_id] = check_city(key, addresses[key][:city_id])
      end
    end

    def check_city(key, city)
      if City.find_by(name: city)
        City.find_by(name: city).id
      else
        c = City.create(name: city)
        c.id
      end
    end

    def set_defaults
      addresses = params[:user][:addresses_attributes]
      billing = params[:user][:billing_id]
      shipping = parms[:user][:shipping_id]

      if billing
        billing_street = addresses[billing][:street_address]
        @user.billing_address = @user.addresses.find_by(street_address: billing_street)
      end

      if shipping
        shipping_street = addresses[shipping][:street_address]
        @user.shipping_address = @user.addresses.find_by(street_address: shipping_street)
      end
      @user.save
    end
  end
end
