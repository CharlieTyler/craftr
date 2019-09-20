class Collection < ApplicationRecord
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  has_many :collection_products, dependent: :destroy
  has_many :products, through: :collection_products
  belongs_to :category, required: false

  validates :name, presence: true
  validates :description, presence: true
  accepts_nested_attributes_for :collection_products, reject_if: proc { |attributes| attributes['product_id'].blank? }

  mount_uploader :image, ProductImageUploader

  def full_name
    if category_id.present?
      "#{name} #{category.name}s"
    else
      name
    end
  end

  def self.search(params)
    search_scope = Collection

    if params[:keyword].present?
      search_scope = search_scope.where("lower(CONCAT(name,' ', description)) LIKE lower(?)", "%#{params[:keyword]}%")
    end

    search_scope
  end
end
