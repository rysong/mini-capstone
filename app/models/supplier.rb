class Supplier < ApplicationRecord

  def products
    Products.where(supplier_id: id)
  end

  def as_json
    {
      name: name, 
      email: email,
      phone_number: phone_number
    }
  end 

end 
