class Admin::FeaturedItemsController < AdminController
  def edit
    @products = Product.all
    @featured_product_ids = Product.where(featured: true).map{|p| p.id}
    @categories = Category.all
    @featured_category_ids = Category.where(featured: true).map{|c| c.id}
  end

  def update
    if params[:product_id].present?
      Product.update_all(featured: false)
      Product.where(:id => params[:product_id]).update_all(featured: true)
    elsif params[:category_id].present?
      Category.update_all(featured: false)
      Category.where(:id => params[:category_id]).update_all(featured: true)
    end

    redirect_to admin_dashboard_path
  end
end
