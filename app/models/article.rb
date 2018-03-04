class Article < ApplicationRecord
  belongs_to :author

  has_many :article_categories
  has_many :article_distilleries
  has_many :article_products
  has_many :article_recipes

  accepts_nested_attributes_for :article_categories, reject_if: proc { |attributes| attributes['category_id'].blank? }
  accepts_nested_attributes_for :article_distilleries, reject_if: proc { |attributes| attributes['distillery_id'].blank? }
  accepts_nested_attributes_for :article_products, reject_if: proc { |attributes| attributes['product_id'].blank? }
  accepts_nested_attributes_for :article_recipes, reject_if: proc { |attributes| attributes['recipe_id'].blank? }

  has_many :categories, through: :article_categories
  has_many :distilleries, through: :article_distilleries
  has_many :products, through: :article_products
  has_many :recipes, through: :article_recipes

  mount_uploader :banner_image, DistilleryBannerImageUploader
  mount_uploader :image_first, ArticleImageUploader
  mount_uploader :image_second, ArticleImageUploader
  mount_uploader :image_third, ArticleImageUploader

  validates :title, presence: true
  validates :description, presence: true
  validates :banner_image, presence: true
  validates :description_first, presence: true
  validates :image_first, presence: true

  def self.search(params)
    search_scope = Article

    if params[:keyword].present?
      search_scope = search_scope.where("lower(CONCAT(title,' ', description)) LIKE lower(?)", "%#{params[:keyword]}%")
    end

    search_scope
  end
end
