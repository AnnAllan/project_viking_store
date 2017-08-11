class OrdersController < ApplicationController
  before_action :verify_user, only:[:create, :edit]
  before_action :verify_cart, only:[:create]

  def index
  end

  def show
  end

  def new
  end

  def create
    if current_user.cart.present?
      @order = current_user.cart
      @order.order_contents.destroy_all
    else
      @order = current_user.orders.build
    end
    session[:cart].each do |k, v|
      @order.order_contents.build(product_id: k, quantity: v)
    end
    @order.save!
    redirect_to edit_order_path(@order)
  end

  def edit
    @order = current_user.cart
    if current_user.credit_cards.present?
      @order.credit_card_id = current_user.credit_cards.first
    else
      @order.build_credit_card(user_id: @order.user.id)
    end
  end

  def update
    @order = Order.find(params[:id])
    if current_user.credit_cards.present?
      @order.credit_card = current_user.credit_cards.first
    else
      @order.build_credit_card(safe_params)
      unless @order.credit_card.save
        flash[:error] = "Credit card could not be processed."
      end
    end
    if @order.update(checkout_params) && order_payment_info_complete?
      flash[:success] = "Thank you for your purchase."
      @order.checkout_date = Time.now
      @order.save
      session.delete(:cart)
      redirect_to root_path
    else
      flash[:error] = "Order could not be processed."
      render :edit
    end
  end

  private

  def verify_cart
    session[:cart] ||={}
    if session[:cart].empty?
      flash[:error] = "Please add items to your cart to view"
      redirect_to root_path
    end
  end

  def verify_user
    unless signed_in_user?
      flash[:error] = "Please sign in to check out."
      redirect_to new_session_path
    end
  end

  def checkout_params
    params.require(:order).permit(:id, :shippng_id, :billing_id)
  end

  def safe_params
    params[:credit_card][:user_id] = current_user.id
    params.require(:credit_card).permit(:id, :card_number, :exp_month, :exp_year, :ccv, :user_id)
  end

  def order_payment_info_complete?
    @order.billing_address && @order.shipping_address && @order.credit_card
  end
end
