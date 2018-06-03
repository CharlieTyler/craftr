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
      if current_user.orders.where(paid: false).present?  # find non-complete order
        @order = current_user.orders.where(paid: false).first
        # Should probably delete others
      elsif session[:order_id].present? # if built a cart without being logged in and is now logged in
        @order = Order.find(session[:order_id])
        if @order.user_id.blank? # if hasn't already updated
          @order.update_attributes(user_id: current_user.id) # update user
        end
        session[:order_id] = nil # and remove from unassigned carts
      else
        @order = Order.create(user_id: current_user.id)
      end
    elsif session[:order_id].present?
      @order = Order.find(session[:order_id])
    else
      @order = Order.create
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

  helper_method :youtube_embed
  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    %Q{<iframe class = "embed-responsive-item" title="YouTube video player" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end
end
