class V1::CartedProductsController < ApplicationController
  before_action :authenticate_user

  def index 
    carted_products = current_user.carted_products.where(status: "carted") 
    render json: carted_products.as_json
  end 

  def create

    carted_product = CartedProduct.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity].to_i,
      status: "carted" 
      )

    if carted_product.save #happy or sad path logic 
      render json: carted_product.as_json 
    else 
      render json: {errors: carted_product.errors.full_messages}, status: :unprocessable_entity
    end 
  end 

  def destroy 
    carted_product_id = params["id"]
    carted_product = CartedProduct.find_by(id: carted_product_id)

    carted_product.status = "removed"
    carted_product.save 
    render json: {message: "carted product #{carted_product_id} successfully removed"}
  end 

end
