class ProductsController < ApplicationController
  def show
    @product                   = Product.friendly.find(params[:id])
    @distillery                = @product.distillery
    @review                    = Review.new
    @recipes                   = @product.recipes
    @other_distillery_products = @product.distillery.products.live.where.not(id: @product.id)
    @other_popular_products    = @product.other_popular_products.first(6)
    @order_item                = OrderItem.new
    UserProductView.create(user: user_signed_in? ? current_user : nil, product: @product)
  end

  def index
    @products = Product.live
  end

  def random
    @product = Product.order("RANDOM()").first
    redirect_to product_path(@product)
  end
end
