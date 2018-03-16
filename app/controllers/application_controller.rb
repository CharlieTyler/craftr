class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart

  private

  # Copied from https://jedrekdomanski.wordpress.com/2017/02/05/building-a-shopping-cart-in-ruby-on-rails-part-1/
  # def set_cart
  #   @cart = Cart.find(session[:cart_id])
  # rescue ActiveRecord::RecordNotFound
  #   @cart = Cart.create
  #   session[:cart_id] = @cart.id
  # end


  # currently doesn't account for users - probably want something like this... to be checked with Matt

  def set_cart
    if user_signed_in?
      if current_user.cart.present? #based on a has_one relationship - note: never used this yet
        @cart = current_user.cart
      else
        @cart = Cart.create(user_id: current_user.id)
      end
    elsif Cart.find(session[:cart_id]).exists?
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
