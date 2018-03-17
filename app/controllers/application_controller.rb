class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart

  private

  # Copied from https://jedrekdomanski.wordpress.com/2017/02/05/building-a-shopping-cart-in-ruby-on-rails-part-1/ and then altered to deal with Devise
  def set_cart
    if user_signed_in?
      if current_user.orders.where.not(state: "complete").present?  # find non-complete order
        @order = current_user.orders.where.not(state: "complete").first
      elsif session[:order_id].present? # if built a cart without being logged in and is now logged in
        @order = Order.find(session[:order_id])
        if @order.user_id.blank? # if hasn't already updated
          @order.update_attributes(user_id: current_user.id) # update user
        end
        session[:order_id] = nil # and remove from unassigned carts
      else
        @order = Order.create(user_id: current_user.id, state: "cart")
      end
    elsif session[:order_id].present?
      @order = Order.find(session[:order_id])
    else
      @order = Order.create(state: "cart")
      session[:order_id] = @order.id
    end
  end



  helper_method :navbar_categories
  def navbar_categories
    @navbar_categories = Category.all
  end

  def authenticate_is_author
    unless user_signed_in? && current_user.is_author?
      render plain: 'Unauthorized', status: :unauthorized
    end
  end
end
