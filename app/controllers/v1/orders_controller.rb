class V1::OrdersController < ApplicationController
  before_action :authenticate_user
  
  def index 
  
    orders = current_user.orders 
    render json: orders.as_json
    
  end 

  def create 

    carted_products = current_user.carted_products.where(status: "carted") 
    subtotal = carted_products.map{|carted_product| carted_product.product.price * carted_product.quantity}.sum
    tax = subtotal * 0.09
    total = subtotal + tax 

    order = Order.new(
      user_id: current_user.id,
      subtotal: subtotal,
      tax: tax,
      total: total
      )
    order.save 

    carted_products.each do |carted_product| 
      carted_product.status = "purchased" 
      carted_product.order_id = order.id 
      carted_product.save
    end 

     #carted_products.update_all(status: "purchased", order_id: order.id) / active record shortcut for lines 28-32
    
    render json: order.as_json 
  
  end 
end
