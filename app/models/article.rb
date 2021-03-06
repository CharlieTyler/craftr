class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  acts_as_taggable_on :tags

  belongs_to :author

  has_many :article_categories, dependent: :destroy
  has_many :article_distilleries, dependent: :destroy
  has_many :article_products, dependent: :destroy
  has_many :article_recipes, dependent: :destroy

  accepts_nested_attributes_for :article_categories, reject_if: proc { |attributes| attributes['category_id'].blank? }
  accepts_nested_attributes_for :article_distilleries, reject_if: proc { |attributes| attributes['distillery_id'].blank? }
  accepts_nested_attributes_for :article_products, reject_if: proc { |attributes| attributes['product_id'].blank? }
  accepts_nested_attributes_for :article_recipes, reject_if: proc { |attributes| attributes['recipe_id'].blank? }

  has_many :categories, through: :article_categories
  has_many :distilleries, through: :article_distilleries
  has_many :products, through: :article_products
  has_many :recipes, through: :article_recipes

  has_many :user_article_views

  mount_uploader :banner_image, DistilleryBannerImageUploader
  mount_uploader :image_first, ArticleImageUploader
  mount_uploader :image_second, ArticleImageUploader
  mount_uploader :image_third, ArticleImageUploader
  mount_uploader :image_fourth, ArticleImageUploader
  mount_uploader :image_fifth, ArticleImageUploader

  validates :title, presence: true
  validates :description, presence: true
  validates :banner_image, presence: true
  validates :description_first, presence: true
  validates :image_first, presence: true

  def seo_description
    "#{description} - a CRAFTR article by #{author.name}"
  end

  def seo_keywords
    "#{title.split(" ").join(", ")}, #{categories.map(&:name).join(", ")}, craftr, crafter"
  end

  def self.search(params)
    search_scope = Article

    if params[:keyword].present?
      search_scope = search_scope.where("lower(CONCAT(title,' ', description)) LIKE lower(?)", "%#{params[:keyword]}%")
    end

    search_scope
  end

  def read_time
    all_text = [description_first,description_second,description_third,description_fourth,description_fifth].join(" ")
    word_count = all_text.split.size
    word_count
    (word_count.to_f / 200).ceil
  end
end
