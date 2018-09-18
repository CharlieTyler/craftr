class ProductsController < ApplicationController
  def show
    @product                   = Product.friendly.find(params[:id])
    if @product.is_test
      unless user_signed_in? && current_user.admin
        flash[:notice] = "You are not permitted to view test products - please log in to an admin account"
        redirect_to distilleries_path
      end
    end
    @distillery                = @product.distillery
    @review                    = Review.new
    @recipes                   = @product.recipes
    @other_distillery_products = @product.distillery.products.live.where.not(id: @product.id)
    @other_popular_products    = @product.other_popular_products.first(6)
    @order_item                = OrderItem.new
    UserProductView.create(user: user_signed_in? ? current_user : nil, product: @product)
    # SEO
    @page_description          = @product.seo_description
    @page_keywords             = @product.seo_keywords
  end

  def index
    @categories = Category.all
    # Filtering doesn't yet work
    @products = Product.live.filter(filter_params).page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
    # SEO
    @page_description          = "Find and buy craft #{category_list.split(", ").to_sentence} straight from the distilleries."
    @page_keywords             = "Craft, spirits, distillery, bottle, #{category_list}"
  end

  def random
    @product = Product.order("RANDOM()").first
    redirect_to product_path(@product)
  end
end

private

def filter_params
  params.permit(:strength_min, :strength_max, :category_id => [], :distillery_id => [])
end

