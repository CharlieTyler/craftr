class ShippingType < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  has_many :orders
  
  def human_readable_price
    if price == 0
      "FREE"
    else
      number_to_currency((price.to_f / 100), unit: "£")
    end
  end

  def full_shipping_type
    [name, shipping_time, human_readable_price].join(", ")
  end
end
