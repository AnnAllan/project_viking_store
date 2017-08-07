class ProductsController < ApplicationController
  def index
    @filter = params[:products_filter]
    @products = @filter.present? ? Product.of_category(@filter).paginate(:page=> params[:page], :per_page => 6) : Product.paginate(:page=> params[:page], :per_page => 6)
  end

  def show
  end
end
