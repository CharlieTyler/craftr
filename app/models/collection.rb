class Collection < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :collection_products, dependent: :destroy
  belongs_to :category, required: false

  validates :name, presence: true
  validates :description, presence: true
  accepts_nested_attributes_for :collection_products, reject_if: proc { |attributes| attributes['product_id'].blank? }

  mount_uploader :image, ProductImageUploader
end
