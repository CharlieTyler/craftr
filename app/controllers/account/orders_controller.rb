class Account::OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user_order = Order.find(params[:id])
    @relevant_recipes = @user_order.order_items.first.product.related_recipes
    unless @user_order.paid && @user_order.user = current_user
      flash[:alert] = "You may only view your own, completed orders"
      redirect_to me_path
    end
  end

  def index
    @orders = current_user.orders.where(paid: true).order('updated_at DESC').page(params[:page])
    if current_user.sold_items.length > 0
      @previously_purchased_products = current_user.previously_purchased_products.first(4)
    end
  end
end
