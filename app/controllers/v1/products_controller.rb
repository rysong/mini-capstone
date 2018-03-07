class V1::ProductsController < ApplicationController
  def show_products
    products = Product.all 
    render json: products.as_json #as_json is assumed if not typed in
  end 

  def first_product
    product = Product.find_by(id: 1)
    render json: product.as_json 
  end 

  def second_product
    product = Product.find_by(id: 2)
    render json: {product_2: product}
  end 

end
