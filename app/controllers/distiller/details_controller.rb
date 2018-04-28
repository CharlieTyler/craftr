class Distiller::DetailsController < DistillersController
  require 'net/http'
  require 'uri'

  def transactional_checklist
    # current_distillery set as helper method in Distillers Controller
    @address = Address.new
  end

  def register_stripe_key
    options = {
      site: 'https://connect.stripe.com',
      authorize_url: '/oauth/authorize',
      token_url: '/oauth/token'
    }
    code = params[:code]
    client = OAuth2::client.new(ENV['CLIENT_ID'], ENV['SECRET_KEY'], options)
    @resp = client.auth_code.get_token(code, :params => {:scope => 'read_write'})
    @access_token = @resp.token
    current_distillery.update_attributes(stripe_id: @resp.params["stripe_user_id"]) if @resp
    flash[:notice] = "Your account has been successfully created and is ready to process payments!"
    redirect_to distillery_dashboard_path
  end
end
