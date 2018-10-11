class ShippingType < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  has_many :orders
  
  def human_readable_price
    number_to_currency((price.to_f / 100), unit: "£")
  end

  def full_shipping_type
    [name, shipping_time, human_readable_price].join(", ")
  end
end
