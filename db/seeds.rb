# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

 product = Product.new(name:"iPhone", price:700, image_url:"https://goo.gl/images/ZXysWy", description:"Apple phone")
 product.save
 product = Product.new(name:"Galaxy S8", price:750, image_url:"https://goo.gl/images/5fZZP1", description:"Samsung phone")
 product.save

 #product = Product.create(...) .create does .new and then .save in one method 