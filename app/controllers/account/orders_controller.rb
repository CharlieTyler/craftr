class Account::OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @order = Order.find(params[:id])
    @relevant_recipes = @order.order_items.first.product.related_recipes
    unless @order.paid && @order.user = current_user
      flash[:alert] = "You may only view your own, completed orders"
      redirect_to me_path
    end
  end

  def index
    @orders = current_user.orders.where(paid: true)
    @products = current_user.most_purchased_products.first(4)
  end
end
