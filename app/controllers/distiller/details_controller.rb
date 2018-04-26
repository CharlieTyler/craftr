class Distiller::DetailsController < ApplicationController
  def register_stripe_key
    flash[:notice] = "Attempt at registering stripe key"
    redirect_to distiller_dashboard_path
  end
end
