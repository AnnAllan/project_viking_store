module ProductsHelper
  def get_product(product_id)
    Product.find(product_id.to_i)
  end
end
