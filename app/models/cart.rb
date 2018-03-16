class Cart < ApplicationRecord
  has_many :cart_products
  belongs_to :user, required: false
end
