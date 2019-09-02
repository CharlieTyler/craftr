class ProductsController < ApplicationController
  def show
    @product                   = Product.includes(:product_images, :reviews, :distillery).friendly.find(params[:id])
    if @product.is_test
      unless user_signed_in? && current_user.admin
        flash[:notice] = "You are not permitted to view test products - please log in to an admin account"
        redirect_to distilleries_path
      end
    end
    @product_images            = @product.product_images.rank(:row_order)
    @distillery                = @product.distillery
    @review                    = Review.new
    @reviews                   = @product.reviews
    @suggested_recipe          = @product.recipes.first
    @other_recipes             = @product.recipes.drop(1)
    @other_distillery_products = Product.includes(:product_images, :reviews).live.where(distillery_id: @product.distillery.id).where.not(id: @product.id)
    @other_popular_products    = @product.other_popular_products.sample(3)
    @order_item                = OrderItem.new
    @collections               = @product.collections
    UserProductView.create(user: user_signed_in? ? current_user : nil, product: @product)
    # SEO
    @page_description          = @product.seo_description
    @page_keywords             = @product.seo_keywords
  end

  def index
    @categories = Category.all
    
    # order by weight ASC puts those with nil last - bit of a hack, but works
    @products = Product.filter(filter_params).order('featured DESC').transactional.page(params[:page])
    @filterable_distilleries = Distillery.transactional.live
    respond_to do |format|
      format.html
      format.js
    end
    # SEO
    @page_description          = "Find and buy craft #{category_list.split(", ").to_sentence} straight from the distilleries."
    @page_keywords             = "Craft, spirits, distillery, bottle, #{category_list}"
  end

  def random
    @product = Product.transactional.order("RANDOM()").first
    redirect_to product_path(@product)
  end

  private

  def filter_params
    params.permit(:strength_min, :strength_max, :category_id => [], :distillery_id => [])
  end
end


