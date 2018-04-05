class Author < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user

  has_many :articles

  has_many :recipes

  mount_uploader :mugshot, ProductImageUploader
  mount_uploader :background_image, RecipeBannerImageUploader
end
