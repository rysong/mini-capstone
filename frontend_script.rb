require "Unirest"
system "clear"

puts "Welcome to the products store!" 

response = Unirest.get("http://localhost:3000/products")
products = response.body["products"]

index = 0 
puts "The items are: "
products.length.times do 
  puts "#{index + 1}. #{products[index]["name"]}" 
  index = index + 1 
end 




