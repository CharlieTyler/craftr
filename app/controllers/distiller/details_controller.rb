class Distiller::DetailsController < DistillersController
  require 'net/http'
  require 'uri'

  def transactional_checklist
    # current_distillery set as helper method in Distillers Controller
    @address = Address.new
  end

  def register_stripe_key
    # Taken from https://medium.com/@darealdemdestin/setting-up-stripe-connect-w-rails-e9b9dfde6c1e
    options = {
      site: 'https://connect.stripe.com',
      authorize_url: '/oauth/authorize',
      token_url: '/oauth/token'
    }
    code = params[:code]
    client = OAuth2::Client.new(Stripe.client_id, Stripe.api_key, options)
    @resp = client.auth_code.get_token(code, :params => {:scope => 'read_write'})
    @access_token = @resp.token
    current_distillery.update_attributes(stripe_id: @resp.params["stripe_user_id"]) if @resp
    flash[:notice] = "Your Stripe account has been successfully linked - we're ready to process payments!"
    redirect_to distiller_dashboard_path
  end
end
