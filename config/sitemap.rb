require 'fog-aws'

SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(fog_provider: 'AWS',
                                         aws_access_key_id: ENV['AWS_ACCESS_KEY'],
                                         aws_secret_access_key: ENV['AWS_SECRET_KEY'],
                                         fog_directory: ENV['AWS_BUCKET'],
                                         fog_region: ENV['AWS_REGION'])

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.craftr.co.uk"
# pick a place safe to write the files
SitemapGenerator::Sitemap.public_path = 'tmp/'
# store on S3 using Fog (pass in configuration values as shown above if needed)
SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new
# inform the map cross-linking where to find the other maps
# SitemapGenerator::Sitemap.sitemaps_host = "http://#{ENV['FOG_DIRECTORY']}.s3.amazonaws.com/"
# pick a namespace within your bucket to organize your maps
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'

SitemapGenerator::Sitemap.create do
  # Static pages
  add '/about'
  add '/contact'
  add '/privacy-policy'
  add '/me'

  # Articles
  add articles_path, :priority => 0.7, :changefreq => 'daily'
  Article.find_each do |article|
    add article_path(article), :lastmod => article.updated_at
  end

  # Recipes
  add recipes_path, :priority => 0.7, :changefreq => 'daily'
  Recipe.find_each do |recipe|
    add recipe_path(recipe), :lastmod => recipe.updated_at
  end

  # Products
  add products_path, :priority => 0.7, :changefreq => 'daily'
  Product.live.find_each do |product|
    add product_path(product), :lastmod => product.updated_at
  end

  # Categories
  Category.find_each do |category|
    add category_path(category), :priority => 0.9, :changefreq => 'daily'
  end

  # Distilleries
  add distilleries_path, :priority => 0.6, :changefreq => 'daily'
  Distillery.find_each do |distillery|
    add distillery_path(distillery)
  end

  # Bloggers
  add authors_path
  Author.find_each do |author|
    add author_path(author)
  end
end