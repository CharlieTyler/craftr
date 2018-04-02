class Admin::FeaturedItemsController < AdminController
  def edit
    @products = Product.all
    @featured_product_ids = Product.where(featured: true).map{|p| p.id}
    @categories = Category.all
    @featured_category_ids = Category.where(featured: true).map{|c| c.id}
    @recipes = Recipe.all
    @featured_recipe_ids = Recipe.where(featured: true).map{|r| r.id}
    @articles = Article.all
    @featured_article_ids = Article.where(featured: true).map{|a| a.id}
  end

  def update
    if params[:product_id].present?
      Product.update_all(featured: false)
      Product.where(:id => params[:product_id]).update_all(featured: true)
    elsif params[:category_id].present?
      Category.update_all(featured: false)
      Category.where(:id => params[:category_id]).update_all(featured: true)
    elsif params[:recipe_id].present?
      Recipe.update_all(featured: false)
      Recipe.where(:id => params[:recipe_id]).update_all(featured: true)
    elsif params[:article_id].present?
      Article.update_all(featured: false)
      Article.where(:id => params[:article_id]).update_all(featured: true)
    end

    redirect_to admin_dashboard_path
  end
end
