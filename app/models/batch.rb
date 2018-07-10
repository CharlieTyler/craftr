class Batch < ApplicationRecord
  include ActionView::Helpers::TextHelper
  has_many :sold_items
  belongs_to :distillery
  accepts_nested_attributes_for :sold_items, reject_if: proc { |attributes| attributes['sold_item_id'].blank? }

  def description
    "#{pluralize(sold_items.sum(&:quantity), 'parcel')}, batched at #{created_at.strftime('%B %d, %Y at %H:%M')}"  
  end 
end
