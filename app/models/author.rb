class Author < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :user, required: false
  belongs_to :distillery, required: false

  has_many :articles, dependent: :destroy

  has_many :recipes, dependent: :destroy

  mount_uploader :bio_image, CategoryBannerUploader
  mount_uploader :mugshot, DistilleryLogoUploader
  mount_uploader :background_image, RecipeBannerImageUploader

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :bio, presence: true
end
