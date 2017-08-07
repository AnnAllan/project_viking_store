class CartsController < ApplicationController
  def create
    session[:cart] ||= {}
    item = params[:item]

    if Product.exists?(item) && session[:cart][item]
      session[:cart][item] += 1
      flash[:success] = "Added item to cart."
    elsif Product.exists?(item)
      session[:cart][item] = 1
      flash[:success] = "Item added to cart."
    else
      flash[:error] = "Item could not be added to cart."
    end
    redirect_to products_path({products_filter: params[:products_filter]})
  end

  def edit
    @cart = session[:cart]
    @total = 0
    if @cart
      @cart.each do |product_id, quantity|
        @total += Product.find(product_id).price * quantity
      end
    end
  end

  def update
    @cart = session[:cart]
    params[:order].each do |product_id, quantity|
      session[:cart][product_id] = quantity.to_i
      session[:cart].delete(product_id) if quantity == ("0" || "")
    end
    if params[:remove]
      params[:remove].each do |product_id, _true|
        session[:cart].delete(product_id)
      end
    end
    flash[:success] = "Quantities updated."
    render :edit
  end

  def destroy
    session.delte(:cart)
    flash[:success] = "Items deleted."
    redirect_to root_path
  end
end
