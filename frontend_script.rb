require "Unirest"
require "tty-table"

system "clear"

puts "Welcome to the products store! Choose an option:" 
puts "[1] See all products."
puts "[2] See one product."
puts "[3] Create new product." 

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
  params = {
    "name" => "Google Pixel", 
    "price" => 800,
    "image_url" => "https://goo.gl/images/GCUwZM", 
    "description" => "Google phone"
      }

  response = Unirest.post("http://localhost:3000/v1/products", parameters: params) 
  product = response.body
  puts JSON.pretty_generate(product) 

end 

# table_header = ["Id", "Name", "Price"]
# table_body = products.map { |product| [product["id"], product["name"], product["price"]]}
# table = TTY::Table.new table_header, table_body
# puts table.render(:ascii)


