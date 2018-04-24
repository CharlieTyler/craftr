class Checkout::OrdersController < ApplicationController
  def confirmation
    @confirmed_order = Order.find(session[:confirmed_order_id])
    session[:confirmed_order_id] = nil
  end
end
