class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user, required: false
  validate :addresses_belongs_to_order_user

  def addresses_belongs_to_order_user
    Address.find(billing_address_id).user == user && Address.find(shipping_address_id).user == user
  end

  def total_quantity
    order_items.sum(&:quantity)
  end
end
