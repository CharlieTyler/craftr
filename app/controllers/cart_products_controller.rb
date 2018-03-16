class CartProductsController < ApplicationController
# Cart set in application controller, giving us use of the @cart variable
  def create
    @cart_product = @cart.cart_products.create(cart_product_params)
    if @cart_product.valid?
      flash[:notice] = 'Item successfully added to cart'
    else
      @product = Product.find(params[:product_id])
      flash[:alert] = 'There was an error adding your item to the cart'
      redirect_to product_path(@product)
    end
  end

  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy
  end

  def index

  end

  private

  def cart_product_params
    params.require(:cart_product).permit(:product_id,
                                         :quantity)
  end
end
