Rails.application.routes.draw do
  get "/products" => "products#show_products" 
  get "/first_product" => "products#first_product"
  get "/second_product" => "products#second_product"
end
