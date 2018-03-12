class AdminController < ApplicationController
  before_action :require_admin

  def require_admin
    unless user_signed_in? && current_user.admin
      render plain: 'Unauthorized', status: :unauthorized
    end
  end
end