class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :store_user_location!, if: :storable_location?
  before_action :set_email_sign_up
  before_action :set_cart

  private
  # Its important that the location is NOT stored if:
  # - The request method is not GET (non idempotent)
  # - The request is handled by a Devise controller such as Devise::SessionsController as that could cause an 
  #    infinite redirect loop.
  # - The request is an Ajax request as this can lead to very unexpected behaviour.

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr? 
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def set_email_sign_up
    @email_sign_up = EmailSignUp.new
  end

  # Base of this from https://jedrekdomanski.wordpress.com/2017/02/05/building-a-shopping-cart-in-ruby-on-rails-part-1/ and then altered to deal with Devise

  def set_cart
    if user_signed_in?
      # If there was an order before the person signed in and they had one saved
      if session[:order_id].present? && current_user.unpaid_cart.present?
        # Merge them
        @order = current_user.unpaid_cart.merge_with(Order.find(session[:order_id]))
        # If they both had something in, let the user know we merged them
        if current_user.unpaid_cart.order_items.length > 0 && Order.find(session[:order_id]).order_items.length > 0
          flash[:notice] = "We noticed you had a cart saved from before, so we merged it with the one you just made"
        end
        # Then delete and forget about the one from before
        Order.find(session[:order_id]).delete
        session[:order_id] = nil
      # If they didn't have one saved
      elsif session[:order_id].present?
        # Just assign them the one from before they logged in
        @order = Order.find(session[:order_id])
        @order.update_attributes(user_id: current_user.id)
      # If they only had one saved, use that
      elsif current_user.unpaid_cart.present?
        @order = current_user.unpaid_cart
      else
      # Otherwise create them a new one
        @order = Order.create(user_id: current_user.id)
      end
    # If no-one is signed in 
    elsif session[:order_id].present?
        @order = Order.find(session[:order_id])
    else
      @order = Order.create
      session[:order_id] = @order.id
    end
  end

  helper_method :navbar_categories
  def navbar_categories
    @navbar_categories = Category.rank(:row_order).all
  end

  helper_method :category_list
  def category_list
    navbar_categories.map(&:name).join(", ")
  end

  def authenticate_is_author
    unless user_signed_in? && current_user.is_author?
      render plain: 'Unauthorized', status: :unauthorized
    end
  end

  helper_method :youtube_embed
  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    %Q{<iframe class = "embed-responsive-item" title="YouTube video player" src="https://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end
end
