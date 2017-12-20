class ProductImage < ApplicationRecord
  belongs_to :product
  mount_uploader :photo, ProductImageUploader
end
