class Author < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user

  has_many :articles

  has_many :recipes

  mount_uploader :mugshot, DistilleryLogoUploader
  mount_uploader :background_image, RecipeBannerImageUploader

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :bio, presence: true
  validates :background_image, presence: true
  validates :mugshot, presence: true
end
