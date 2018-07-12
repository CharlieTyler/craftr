class Batch < ApplicationRecord
  include ActionView::Helpers::TextHelper
  has_many :sold_items
  has_many :postages, through: :sold_items

  belongs_to :distillery
  accepts_nested_attributes_for :sold_items, reject_if: proc { |attributes| attributes['sold_item_id'].blank? }

  def description
    description = "#{pluralize(sold_items.sum(&:quantity), 'parcel')}, batched at #{created_at.strftime('%B %d, %Y at %H:%M')}"  
    if created_at < 2.days.ago && !shipped
      description += "-  [URGENT] - batched more than 2 days ago"
    end
    description
  end 

  def state
    if shipped
      return "Shipped"
    elsif scanform_id.present?
      return "Awaiting shipping"
    else
      return "Awaiting shipping label"
    end
  end
end
