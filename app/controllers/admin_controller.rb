class AdminController < ApplicationController
  before_action :require_admin

  def require_admin
    unless user_signed_in? && current_user.admin
      flash[:alert] = "Please log in as an admin to be granted access"
      redirect_to new_user_session_path
    end
  end
end