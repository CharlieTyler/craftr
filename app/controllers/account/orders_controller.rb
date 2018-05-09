class Account::OrdersController < ApplicationController
  before_action :authenticate_user!
  def show
    @order = Order.find(params[:id])
    unless @order.state == "paid" && @order.user = current_user
      flash[:alert] = "You may only view your own, completed orders"
      redirect_to me_path
    end
  end

  def index
    @orders = current_user.orders.where(state: "paid")
  end
end
