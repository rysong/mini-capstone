require "Unirest"
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




