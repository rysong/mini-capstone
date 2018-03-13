class Product < ApplicationRecord
  
  def is_discounted 
    if price < 2
      is_discounted = true 
    else 
      is_discounted = false 
    end 
  end 

  def tax
    tax = price * 0.09 
  end 

  def total 
    total = price + tax 
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
