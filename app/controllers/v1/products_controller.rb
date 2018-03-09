class V1::ProductsController < ApplicationController
  
  def index 
    products = Product.all 
    render json: products.as_json #as_json is assumed if not typed in
  end 

  def show
    product_id = params["id"]
    product = Product.find_by(id: product_id)
    render json: product.as_json 
  end 

  def create 
    product = Product.new({
      name: params["name"],  
      price: params["price"],  
      image_url: params["image_url"], 
      description: params["description"] 
    })

    product.save 
    render json: product.as_json 

  end 
 
end
