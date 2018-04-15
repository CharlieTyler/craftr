class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :product, presence: true
  validates :order, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0, less_than: 20 }

  def subtotal_in_pence
    quantity * product.price
  end

  def product_in_stock_and_live?
    
  end
end