class V1::ProductsController < ApplicationController
  
  def index 
    products = Product.all.order(:id => :asc)

    search_terms = params["input_search_terms"]
    if search_terms
      products = products.where("name ILIKE ?", "%#{search_terms}%") #ILIKE ignores case
    end 

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
      description: params["description"],
      in_stock: params["in_stock"]
    })

    if product.save #happy or sad path logic 
      render json: product.as_json 
    else 
      render json: {errors: product.errors.full_messages}, status: :unprocessable_entity
    end 
  end 
 
  def update 
    product_id = params["id"]
    product = Product.find_by(id: product_id)

    product.name = params["name"]||product.name 
    product.price = params["price"]||product.price 
    product.image_url = params["image_url"]||product.image_url  
    product.description = params["description"]||product.description 
    product.in_stock = params["in_stock"]||product.in_stock 

    if product.save 
      render json: product.as_json 
    else 
      render json: {errors: product.errors.full_messages}, status: :unprocessable_entity 
    end 
  end 

  def destroy 
    product_id = params["id"]
    product = Product.find_by(id: product_id)

    product.destroy 
    render json: {message: "product #{product_id} successfully destroyed"}
  end 
end
