class ProductsController < ApplicationController
  def show
    @product          = Product.friendly.find(params[:id])
    @distillery       = @product.distillery
    @review           = Review.new
    @recipes          = @product.recipes
    if user_signed_in?
      current_user.viewed_products << @product
    end
  end

  def index
    @products = Product.all
  end
end
