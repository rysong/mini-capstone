Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  
  namespace :v1 do 
    get "/products" => "products#index" 
    get "/products/:id" => "products#show"
    post "/products" => "products#create"
    patch "/products/:id" => "products#update"
    delete "/products/:id" => "products#destroy"

    post "/users" => "users#create"

    post "/orders" => "orders#create"
  end 
end
