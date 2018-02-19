class ProductsController < ApplicationController
  def show
    @product          = Product.find(params[:id])
    @distillery       = @product.distillery
    @review           = Review.new
    if user_signed_in?
      current_user.viewed_products << @product
    end
  end

  def index
    @products = Product.all
  end
end
