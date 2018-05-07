class SoldItem < ApplicationRecord
  belongs_to :product
  belongs_to :order_item
  has_many :postages

  validates :order_id, presence: true
  validates :order_item_id, presence: true
  validates :product_id, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :item_price, numericality: { only_integer: true }
  
  def total_paid
    quantity * item_price
  end

  def total_distillery_received
    quantity * distillery_take
  end
end
