class ProductsController < ApplicationController
  def show
    @product                   = Product.friendly.find(params[:id])
    @distillery                = @product.distillery
    @review                    = Review.new
    @recipes                   = @product.recipes
    @other_distillery_products = @product.distillery.products.where.not(id: @product.id)
    @other_popular_products    = @product.other_popular_products.first(6)
    if user_signed_in?
      current_user.viewed_products << @product
    end
    flash[:notice] = "Craftr is not yet transactional - favourite products to get notified when they're available for purchase"
  end

  def index
    @products = Product.all
  end

  def random
    @product = Product.order("RANDOM()").first
    redirect_to product_path(@product)
  end
end
