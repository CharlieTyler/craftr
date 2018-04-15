class FavouriteProductsController < ApplicationController
  respond_to :js
  
  def create
    @product = Product.friendly.find(params[:product_id])
    current_user.favourite_products << @product
  end

  def destroy
    @product = Product.friendly.find(params[:product_id])
    current_user.favourite_products.delete(@product)
    flash[:alert] = "Product successfully deleted"
    redirect_to root_path
  end
end
