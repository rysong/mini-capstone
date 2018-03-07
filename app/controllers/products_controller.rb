class ProductsController < ApplicationController
  def show_products
    products = Product.all 
    render json: {products: products}
  end 
end
