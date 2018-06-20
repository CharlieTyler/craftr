class User < ApplicationRecord
  after_create :subscribe_to_mailchimps
  after_update :subscribe_or_unsubscribe_from_mailchimp_on_change

  #author
  has_one :author

  #cart
  has_many :orders
  has_many :sold_items, through: :orders
  has_many :purchased_products, through: :sold_items, source: :product

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

  def previously_purchased_products
    products = []
    orders.each do |order|
      order.sold_items.each do |oi|
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

  def recently_ordered_products
    purchases = sold_items.where("(sold_items.created_at > ? AND sold_items.created_at < ?)", Time.now.in_time_zone('London') - 4.weeks, Time.now.in_time_zone('London') - 5.days)
    recently_ordered_products = []
    purchases.each do |purchase|
      recently_ordered_products.push(purchase.product) unless recently_ordered_products.include?(purchase.product)
    end
    recently_ordered_products 
  end

  def recently_viewed_products
    viewed_user_products = user_product_views.where("(created_at > ?)", Time.now.in_time_zone('London') - 5.days).order("created_at DESC")
    recently_viewed_products = []
    viewed_user_products.each do |vup|
      recently_viewed_products.push(vup.product) unless recently_viewed_products.include?(vup.product)
    end
    recently_viewed_products
  end

  def subscribe_to_mailchimps
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

  def subscribe_or_unsubscribe_from_mailchimp_on_change
    if saved_change_to_newsletter_sign_up?
      if newsletter_sign_up
        subscribe_to_mailchimps
      else
        gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'])
        list_id = ENV['MAIN_MAILCHIMP_LIST']
        gibbon.lists(list_id).members(Digest::MD5.hexdigest(email)).update(body: { status: "unsubscribed" })
      end
    end
  end
end
