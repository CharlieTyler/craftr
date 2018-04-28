class Distillery < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  # distillery portal access
  has_many :users
  
  has_many :products

  #articles
  has_many :article_distilleries
  has_many :articles, through: :article_distilleries

  #address
  has_one :address


  #Validations: does not require blurb & image 2&3, or fb, long and lat
  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :summary_text, presence: true
  validates :summary_image, presence: true
  validates :people_text, presence: true
  validates :people_image, presence: true
  validates :range_text, presence: true
  validates :range_image, presence: true
  validates :blurb_1, presence: true
  validates :image_1, presence: true
  validates :website, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

  mount_uploader :logo, DistilleryLogoUploader
  mount_uploader :summary_image, DistilleryBannerImageUploader
  mount_uploader :people_image, DistilleryBannerImageUploader
  mount_uploader :range_image, DistilleryBannerImageUploader
  mount_uploader :image_1, ArticleImageUploader
  mount_uploader :image_2, ArticleImageUploader
  mount_uploader :image_3, ArticleImageUploader

  def is_transactional
    stripe_id.present? && address.present?
  end
end
