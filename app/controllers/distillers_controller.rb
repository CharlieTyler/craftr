class DistillersController < ApplicationController
  # This is for the distillery portal, namespaced distillers, to inherit from
  before_action :require_distiller

  def require_distiller
    unless user_signed_in? && current_user.distillery.present?
      flash[:alert] = "Please log in as an authorised distiller to be granted access"
      redirect_to new_user_session_path
    end
  end
end
