Rails.application.routes.draw do
  namespace :v1 do 
    get "/products" => "products#show_products" 
    get "/first_product" => "products#first_product"
    get "/second_product" => "products#second_product"

    get "/any_product" => "products#any_product"
  end 
end
