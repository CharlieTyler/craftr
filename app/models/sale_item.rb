class SaleItem < ApplicationRecord
  belongs_to :sale
  belongs_to :product
  belongs_to :order_item
end
