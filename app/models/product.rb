class Product < ApplicationRecord
  
  def is_discounted 
    price < 2 #returns true or false  
  end 

  def tax
    price * 0.09 
  end 

  def total 
    price + tax 
  end 

  def as_json
    {
      id: id, 
      name: name, 
      price: price, 
      image_url: image_url, 
      description: description,
      is_discounted: is_discounted,
      tax: tax,
      total: total 
    }
  end 

end
