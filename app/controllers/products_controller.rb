class ProductsController < ApplicationController
  def show_products
    products = Product.all 
    render json: {products: products}
  end 

  def first_product
    product = Product.find_by(id: 1)
    render json: {product_1: product}
  end 

  def second_product
    product = Product.find_by(id: 2)
    render json: {product_2: product}
  end 

end
