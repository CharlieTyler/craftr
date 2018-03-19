class ShippingType < ApplicationRecord
  has_many :orders
  
  def human_readable_price
    "£#{(price / 100).to_f}"
  end

  def full_shipping_type
    [name, shipping_time, human_readable_price].join(", ")
  end
end
