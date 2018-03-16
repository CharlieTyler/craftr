class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :product, presence: true
  validates :cart, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0, less_than: 20 }

  def subtotal
    (quantity * product.price).to_f / 100
  end
end