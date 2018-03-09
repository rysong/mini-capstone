Rails.application.routes.draw do
  namespace :v1 do 
    get "/products" => "products#index" 
    get "/products/:id" => "products#show"

    get "/any_product" => "products#any_product"
    get "/any_product/:id" => "products#any_product"
  end 
end
