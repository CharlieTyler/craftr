class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_one :sold_item

  validates :product, presence: true
  validates :order, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0, less_than: 20 }

  def subtotal_in_pence
    quantity * product.price
  end

  def original_subtotal_in_pence
    if product.original_price.present?
      quantity * product.original_price
    end
  end

  def product_in_stock_and_live?
    
  end
end