class Distiller::DetailsController < DistillersController
  require 'net/http'
  require 'uri'

  def transactional_checklist
    # current_distillery set as helper method in Distillers Controller
    @address = Address.new
  end

  def register_stripe_key
    if current_distillery.update_attributes({
          stripe_id: request.env["omniauth.auth"].credentials.token
        })
      flash[:notice] = "Successfully connected to Stripe"
      redirect_to distiller_transactional_checklist_path
    else
      flash[:alert] = "Error connecting to Stripe"
      redirect_to distiller_transactional_checklist_path
    end
  end
end
