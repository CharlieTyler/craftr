class SoldItem < ApplicationRecord
  belongs_to :product
  belongs_to :order_item
  belongs_to :order
  belongs_to :batch, required: false
  has_many :postages

  validates :order_id, presence: true
  validates :order_item_id, presence: true
  validates :product_id, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :item_price, numericality: { only_integer: true }
  validates :distillery_take, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  
  def total_paid
    quantity * item_price
  end

  def total_distillery_received
    quantity * distillery_take
  end

  def state
    if batch_id.present?      
      if shipped
        return "Shipped"
      elsif batch.scanform_id.present?
        return "Awaiting shipping"
      else
        return "Batch awaiting scanform"
      end
    elsif shipping_label_created
      return "Not yet batched"
    else
      return "Awaiting shipping label"
    end
  end

  def description
    "#{quantity} * #{product.name.titleize}"
  end

  def queue_shipped_email
  end

  def send_shipped_email
    OrderNotifierMailer.item_shipped_email(self).deliver_now 
  end
end
