class Product < ApplicationRecord
  validates :name, presence: true 
  validates :name, uniqueness: true
  validates :price, presence: true 
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :description, length: { in: 10..500 } 
  
  def is_discounted 
    price < 2 #returns true or false  
  end 

  def tax
    price * 0.09 
  end 

  def total 
    price + tax 
  end 

  def supplier
    Supplier.find_by(id: supplier_id)
  end 

  def as_json
    {
      id: id, 
      name: name, 
      price: price, 
      description: description,
      in_stock: in_stock, 
      is_discounted: is_discounted,
      tax: tax,
      total: total, 
      supplier: supplier.as_json 
    }
  end 

end
