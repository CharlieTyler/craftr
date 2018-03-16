class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart

  private

  # Copied from https://jedrekdomanski.wordpress.com/2017/02/05/building-a-shopping-cart-in-ruby-on-rails-part-1/ and then altered to deal with Devise
  # currently does not assign session cart to user if subsequently logs in
  def set_cart
    if user_signed_in?
      if current_user.cart.present? #based on a has_one relationship - note: never used this yet
        @cart = current_user.cart
      elsif session[:cart_id].present? # if built a cart without being logged in and is now logged in
        @cart = Cart.find(session[:cart_id])
        if @cart.user_id.blank? # if hasn't already updated
          @cart.update_attributes(user_id: current_user.id) # update user
        end
        session[:cart_id] = nil # and remove from unassigned carts
      else
        @cart = Cart.create(user_id: current_user.id)
      end
    elsif session[:cart_id].present?
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.create
      session[:cart_id] = @cart.id
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
