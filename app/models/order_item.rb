class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product, presence: true
  validates :order, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0, less_than: 20 }

  def subtotal
    (quantity * product.price).to_f / 100
  end
end