class User < ApplicationRecord
  after_create :attempt_to_subscribe_to_mailchimp
  after_update :attempt_to_subscribe_to_mailchimp, :unsubscribe_from_mailchimp

  #author
  has_one :author

  #cart
  has_many :orders

  #completed transactions
  has_many :sales

  #distiller portal
  belongs_to :distillery, required: false

  #addresses
  has_many :addresses

  #favourite products
  has_many :user_favourite_products, dependent: :destroy
  has_many :favourite_products, through: :user_favourite_products, source: :product

  #favourite recipes
  has_many :user_favourite_recipes, dependent: :destroy
  has_many :favourite_recipes, through: :user_favourite_recipes, source: :recipe

  #recipe comments
  has_many :recipe_comments, dependent: :destroy

  #product reviews
  has_many :reviews, dependent: :destroy

  #recently viewed products
  has_many :user_product_views, dependent: :destroy
  has_many :viewed_products, through: :user_product_views, source: :product

  #viewed recipes
  has_many :user_recipe_views, dependent: :destroy
  has_many :viewed_recipes, through: :user_recipe_views, source: :recipe

  #read articles
  has_many :user_article_views, dependent: :destroy
  has_many :read_articles, through: :user_article_views, source: :article

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validates that age verification is a) present and b) true
  validates :age_verified, exclusion: { in: [nil], message: "Age verification is a requirement" }
  validates :age_verified, inclusion: { in: [true], message: "Age verification is a requirement" }

  def is_author?
    author.present?
  end

  def most_purchased_products
    products = []
    orders.each do |order|
      order.order_items.each do |oi|
        products << oi.product 
      end
    end
    products.uniq!
  end

  def favourited_recipe?(recipe)
    favourite_recipes.include? recipe
  end

  def favourited_product?(product)
    favourite_products.include? product
  end

  def recently_viewed_products
    viewed_user_products = user_product_views.where("(created_at > ?)", Time.now - 5.days)
    recently_viewed_products = []
    viewed_user_products.each do |vup|
      recently_viewed_products.push(vup.product) unless recently_viewed_products.include?(vup.product)
    end
    recently_viewed_products
  end

  def attempt_to_subscribe_to_mailchimp
    gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
    if distillery_id.present?
      list_id = ENV["DISTILLER_MAILCHIMP_LIST"]
      gibbon.lists(list_id).members(Digest::MD5.hexdigest(email)).upsert(body: {email_address: email, status: "subscribed"})
    end
    if newsletter_sign_up
      # Might need a model in which to store list ids
      list_id = ENV["MAIN_MAILCHIMP_LIST"]
      gibbon.lists(list_id).members(Digest::MD5.hexdigest(email)).upsert(body: {email_address: email, status: "subscribed"})
    end
  end

  def unsubscribe_from_mailchimp
    unless newsletter_sign_up
      gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
      list_id = ENV['MAIN_MAILCHIMP_LIST']
      gibbon.lists(list_id).members(Digest::MD5.hexdigest(email)).update(body: { status: "unsubscribed" })
    end
  end
end
