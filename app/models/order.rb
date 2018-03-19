class Order < ApplicationRecord
  has_many :order_items
  belongs_to :shipping_type, required: false
  belongs_to :shipping_address, class_name: 'Address', foreign_key: 'shipping_address_id', required: false
  belongs_to :user, required: false
  # validate :addresses_belongs_to_order_user

  def addresses_belongs_to_order_user
    shipping_address.user == user
  end

  def total_quantity
    order_items.sum(&:quantity)
  end

  def total_product_amount
    order_items.to_a.sum(&:subtotal_in_pence)
  end

  def total_shipping_amount
    shipping_type.price * total_quantity
  end

  def total_amount
    total_product_amount + total_shipping_amount
  end
end
