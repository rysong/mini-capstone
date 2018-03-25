require "Unirest"
require "tty-table"

system "clear"
puts "Welcome to the products store! Choose an option:" 
puts "[signup] Signup (create a user)"
puts "[login] Login (create a JSON web token)"
puts "[logout] Logout (delete the JSON web token)"

input_option = gets.chomp 

if input_option == "signup"
  params = {
  name: "Richard",
  email: "richard@email.com",
  password: "password",
  password_confirmation: "password"
  } 
  response = Unirest.post("http://localhost:3000/v1/users", parameters: params)
  p response.body

elsif input_option == "login" 
  response = Unirest.post(
  "http://localhost:3000/user_token",
  parameters: {
    auth: {
      email: "richard@email.com",
      password: "password"
    }
  }
  )
  jwt = response.body["jwt"]
  Unirest.default_header("Authorization", "Bearer #{jwt}")

elsif input_option == "logout"
  jwt = ""
  Unirest.clear_default_headers()
end 
puts "Your jwt is #{jwt}"
puts ""
puts "Press enter to continue"
gets.chomp 

system "clear"
puts "[1] See all products ordered by id."
puts "  [1.1] See all products ordered by price."
puts "  [1.2] Search for a product by name."
puts "[2] See one product."
puts "[3] Create new product." 
puts "[4] Update a product."
puts "[5] Delete a product."
puts "[6] Add items to cart." 
puts "[7] See items in your cart."
puts "[8] Order the items in your cart"
puts "[signup] Signup (create a user)."


input_option = gets.chomp 

if input_option == "1" 
  response = Unirest.get("http://localhost:3000/v1/products?input_sort_by=id")
  products = response.body 
  puts JSON.pretty_generate(products)

elsif input_option == "1.1" 
  response = Unirest.get("http://localhost:3000/v1/products?input_sort_by=price")
  products = response.body 
  puts JSON.pretty_generate(products)

elsif input_option == "1.2" 
  print "Enter a product name to search: "
  input = gets.chomp 
  response = Unirest.get("http://localhost:3000/v1/products?input_search_terms=#{input}")
  products = response.body 
  puts JSON.pretty_generate(products)

elsif input_option == "2"
  print "Enter a product id: "
  product_id = gets.chomp 
  response = Unirest.get("http://localhost:3000/v1/products/#{product_id}")
  product = response.body 

elsif input_option == "3"
  
  params = {}
  puts "Enter a product name:"
  params["name"] = gets.chomp

  puts "Enter a product price:"
  params["price"]= gets.chomp 
    
  puts "Enter a description:"
  params["description"] = gets.chomp

  puts "Enter true if it's in stock or false if it's not:"
  params["in_stock"] = gets.chomp 
  # OR 
  # params = {
  #   "name" => "Google Pixel", 
  #   "price" => 800,
  #   "image_url" => "https://goo.gl/images/GCUwZM", 
  #   "description" => "Google phone"
  #     }

  response = Unirest.post("http://localhost:3000/v1/products", parameters: params) 
  product = response.body

  if product["errors"] 
    puts "Oops, that didn't work: "
    p product["errors"]
  else 
    puts "This is the new product: "
    puts JSON.pretty_generate(product) 
  end 
  

elsif input_option == "4"
  print "Enter a product id:"
  product_id = gets.chomp 

  response = Unirest.get("http://localhost:3000/v1/products/#{product_id}")
  product = response.body 

  params = {}
  print "name (#{product["name"]}): "
  params["name"] = gets.chomp
  print "price (#{product["price"]}): "
  params["price"]= gets.chomp 
  print "description (#{product["description"]}): "
  params["description"] = gets.chomp 
  print "in stock (#{product["in_stock"]}): "
  params["in_stock"] = gets.chomp 

  params.delete_if { |_key, value| value.empty? }
  
  response = Unirest.patch("http://localhost:3000/v1/products/#{product_id}", parameters: params)
  product = response.body 
  
  if product["errors"] 
    puts "Oops, that didn't work: "
    p product["errors"]
  else 
    puts "This is the updated product: "
    puts JSON.pretty_generate(product) 
  end 

elsif input_option == "5"
  print "Enter a product id:"
  product_id = gets.chomp 

  response = Unirest.delete("http://localhost:3000/v1/products/#{product_id}")
  body = response.body
  puts JSON.pretty_generate(body)

elsif input_option == "6"
  params = {}
  puts "Enter a product id you want to buy:"
  params[:product_id] = gets.chomp
  puts "Enter how many you want to buy:"
  params[:quantity] = gets.chomp

  response = Unirest.post("http://localhost:3000/v1/carted_products", parameters: params)
  carted_product = response.body 

  if carted_product["errors"] 
    puts "Oops, that didn't work: "
    p carted_product["errors"]
  else 
    puts "This is what you added to the cart: "
    puts JSON.pretty_generate(carted_product) 
  end 

elsif input_option == "7"
  puts "This is in your cart:"
  response = Unirest.get("http://localhost:3000/v1/carted_products")
  carted_products = response.body 
  puts JSON.pretty_generate(carted_products)

elsif input_option == "8"

  puts "You are ordering the items in your cart."
  response = Unirest.post("http://localhost:3000/v1/orders")
  order = response.body 

  if order["errors"] 
    puts "Oops, that didn't work: "
    p order["errors"]
  else 
    puts "This is your order: "
    puts JSON.pretty_generate(order) 
  end 

elsif input_option == "signup"

  params = {}
  puts "Enter a name:"
  params[:name] = gets.chomp
  puts "Enter an email:"
  params[:email] = gets.chomp
  puts "Enter a password:"
  params[:password] = gets.chomp
  puts "Confirm the password:"
  params[:password_confirmation] = gets.chomp

  response = Unirest.post("http://localhost:3000/v1/users", parameters: params)
  p response.body 

end 

# table_header = ["Id", "Name", "Price"]
# table_body = products.map { |product| [product["id"], product["name"], product["price"]]}
# table = TTY::Table.new table_header, table_body
# puts table.render(:ascii)


