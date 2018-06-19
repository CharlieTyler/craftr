SitemapGenerator::Sitemap.default_host = "https://www.craftr.co.uk"

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