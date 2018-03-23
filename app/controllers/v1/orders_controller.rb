class V1::OrdersController < ApplicationController
  before_action :authenticate_user
  
  def index 
  
    orders = current_user.orders 
    render json: orders.as_json
    
  end 

  def create 

    product_id = params[:product_id]
    quantity = params[:quantity].to_i 

    product = Product.find_by(id: product_id)
    subtotal = product.price * quantity
    tax = subtotal * 0.09 
    total = subtotal + tax 

    order = Order.new(
      user_id: current_user.id, 
      subtotal: subtotal,
      tax: tax,
      total: total 
      )

    if order.save #happy or sad path logic 
      render json: order.as_json 
    else 
      render json: {errors: order.errors.full_messages}, status: :unprocessable_entity
    end 
  end 
end
