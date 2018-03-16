class CartProduct < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def subtotal
    (quantity * product.price).to_f / 100
  end
end