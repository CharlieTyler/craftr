class Distillery < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :live, -> { where(is_live: true, is_test: false) }
  scope :transactional, -> { where("stripe_id <> ''") }

  # distillery portal access
  has_many :users
  
  has_many :products
  has_many :user_product_views, through: :products

  #articles
  has_many :article_distilleries
  has_many :articles, through: :article_distilleries

  has_one :author
  has_many :recipes, through: :author

  #address
  has_one :address

  has_many :batches
  has_many :sold_items, through: :products


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

  def self.search(params)
    search_scope = Distillery

    if params[:keyword].present?
      search_scope = search_scope.where("lower(CONCAT(name,' ', location,' ',summary_text)) LIKE lower(?)", "%#{params[:keyword]}%")
    end

    search_scope
  end

  def seo_description
    "Craft spirits from #{location}. Buy #{products.all.sample(3).map(&:name).to_sentence} - shipped direct from #{name}."
  end

  def seo_keywords
    "#{name}, #{location}, craft, spirits, craftr, crafter"
  end

  def is_transactional
    stripe_id.present? && address.present?
  end

  def total_product_views

  end

  # Auto shipping
  def unshipped_batches
    batches.where(shipped: false)
  end

  def unbatched_sold_items_with_postage_labels
    sold_items.where(manual_shipping: [false, nil], batch_id: nil, shipping_label_created: true)
  end

  def unbatched_sold_items_without_postage_labels
    sold_items.where(manual_shipping: [false, nil], batch_id: nil, shipping_label_created: false)
  end

  # Manual shipping
  def unshipped_manual_sold_items
    sold_items.where(manual_shipping: true, shipped: false)
  end

  def number_of_notifications
    unshipped_batches.length + unbatched_sold_items_without_postage_labels.length + unshipped_manual_sold_items.length
  end
end
