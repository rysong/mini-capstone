require "Unirest"
require "tty-table"

response = Unirest.post(
  "http://localhost:3000/user_token",
  parameters: {
    auth: {
      email: "richard@email.com",
      password: "password" 
    }
  }
)

# Save the JSON web token from the response
jwt = response.body["jwt"]
# Include the jwt in the headers of any future web requests
Unirest.default_header("Authorization", "Bearer #{jwt}")

system "clear"

puts "Your jwt is #{jwt}"
puts "Welcome to the products store! Choose an option:" 
puts "[1] See all products ordered by id."
puts "  [1.1] See all products ordered by price."
puts "  [1.2] Search for a product by name." 
puts "[2] See one product."
puts "[3] Create new product." 
puts "[4] Update a product."
puts "[5] Delete a product"
puts "[signup] Signup (create a user)"

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


