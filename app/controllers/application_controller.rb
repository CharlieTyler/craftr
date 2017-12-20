class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :navbar_categories
  def navbar_categories
    @navbar_categories = Category.all
  end
end
