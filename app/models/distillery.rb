class Distillery < ApplicationRecord
  has_many :products

  #articles
  has_many :article_distilleries
  has_many :articles, through: :article_distilleries

  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :description_short, presence: true
  validates :description_first, presence: true
  validates :description_second, presence: true

  mount_uploader :banner_image, DistilleryBannerImageUploader
  
end
