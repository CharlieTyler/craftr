class ProductImage < ApplicationRecord
  include RankedModel
  ranks :row_order, :with_same => :product_id
  belongs_to :product
  mount_uploader :photo, ProductImageUploader
end
