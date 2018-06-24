class ShippingType < ApplicationRecord
  has_many :orders
  
  def human_readable_price
    "£#{(price.to_f / 100)}"
  end

  def full_shipping_type
    [name, tag('br'), shipping_time, human_readable_price].join(", ")
  end
end
