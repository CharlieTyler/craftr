class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user, required: false

  def address_belongs_to_order
    billing_address.user == order.user
  end
end
