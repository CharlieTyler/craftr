class CartProductsController < ApplicationController
# Cart set in application controller, giving us use of the @cart variable
  def create
    @product = Product.find(params[:cart_product][:product_id])

    # Check if this product is already in the cart
    current_cart_product = @cart.cart_products.find_by(product_id: @product.id)
    if current_cart_product.present?
      # Change the quantity
      current_cart_product.quantity += params[:cart_product][:quantity].to_i
      # Save the change quantity
      current_cart_product.save
      flash[:notice] = "You now have #{current_cart_product.quantity} of these in your cart"
    else
      @cart_product = @cart.cart_products.create(cart_product_params)
      if @cart_product.valid?
        flash[:notice] = 'Item successfully added to cart'
      else
        flash[:alert] = 'There was an error adding your item to the cart'
      end
    end
    redirect_to product_path(@product)
  end

  def destroy
    @cart_product = CartProduct.find(params[:id])
    @cart_product.destroy
  end

  def index
    @cart_products = @cart.cart_products
  end

  private

  def cart_product_params
    params.require(:cart_product).permit(:product_id,
                                         :quantity)
  end
end
