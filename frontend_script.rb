require "Unirest"
require "tty-table"

system "clear"

puts "Welcome to the products store!" 

response = Unirest.get("http://localhost:3000/v1/products")
products = response.body

# puts JSON.pretty_generate(products)   method to print out in JSON format 

index = 0 
puts "The items are: "
products.length.times do 
  puts "#{index + 1}. #{products[index]["name"]}" 
  index = index + 1 
end 

table_header = ["Id", "Name", "Price"]
table_body = products.map { |product| [product["id"], product["name"], product["price"]]}
table = TTY::Table.new table_header, table_body
puts table.render(:ascii)



