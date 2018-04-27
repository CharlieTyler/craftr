class Distiller::DetailsController < DistillersController
  require 'net/http'
  require 'uri'

  def transactional_checklist
    # current_distillery set as helper method in Distillers Controller
    @address = Address.new
  end

  def register_stripe_key
    if params[:error].present?
      flash[:alert] = params[:error_description]
    else
      # Converted from Stripe cURL API docs using https://jhawthorn.github.io/curl-to-ruby/
      uri = URI.parse("https://connect.stripe.com/oauth/token")
      request = Net::HTTP::Post.new(uri)
      request.set_form_data(
        "client_secret" => ENV['SECRET_KEY'],
        "code" => params[:code],
        "grant_type" => "authorization_code",
      )

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      parsed_response = JSON.parse(response)
      token = parsed_response['access_token']
      # current_distillery.update_attributes(stripe_key: token)
      flash[:notice] = token
      redirect_to distiller_transactional_checklist_path
    end
  end
end
