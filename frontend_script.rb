require "Unirest"
require "tty-table"

system "clear"

puts "Welcome to the products store! Choose an option:" 
puts "[1] See all products."
puts "[2] See one product."
puts "[3] Create new product." 
puts "[4] Update a product."
puts "[5] Delete a product"

input_option = gets.chomp 

if input_option == "1" 
  response = Unirest.get("http://localhost:3000/v1/products")
  products = response.body 
  puts JSON.pretty_generate(products)

elsif input_option == "2"
  print "Enter a product id: "
  product_id = gets.chomp 
  response = Unirest.get("http://localhost:3000/v1/products/#{product_id}")
  product = response.body 
  puts JSON.pretty_generate(product) 

elsif input_option == "3"
  
  params = {}
  puts "Enter a product name:"
  params["name"] = gets.chomp

  puts "Enter a product price:"
  params["price"]= gets.chomp 
  
  puts "Enter a product image url:"
  params["image_url"] = gets.chomp 
  
  puts "Enter a description:"
  params["description"] = gets.chomp 

  # OR 
  # params = {
  #   "name" => "Google Pixel", 
  #   "price" => 800,
  #   "image_url" => "https://goo.gl/images/GCUwZM", 
  #   "description" => "Google phone"
  #     }

  response = Unirest.post("http://localhost:3000/v1/products", parameters: params) 
  product = response.body
  puts JSON.pretty_generate(product) 

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
  print "image url (#{product["image_url"]}): "
  params["image_url"] = gets.chomp 
  print "description (#{product["description"]}): "
  params["description"] = gets.chomp 

  params.delete_if { |_key, value| value.empty? }
  
  response = Unirest.patch("http://localhost:3000/v1/products/#{product_id}", parameters: params)
  product = response.body 
  puts JSON.pretty_generate(product) 

elsif input_option == "5"
  print "Enter a product id:"
  product_id = gets.chomp 

  response = Unirest.delete("http://localhost:3000/v1/products/#{product_id}")
  body = response.body
  puts JSON.pretty_generate(body)
end 

# table_header = ["Id", "Name", "Price"]
# table_body = products.map { |product| [product["id"], product["name"], product["price"]]}
# table = TTY::Table.new table_header, table_body
# puts table.render(:ascii)


