class AgeVerificationController < ApplicationController
  def create
    # Should only get here if user not logged in
    session[:age_verified] = true 
    redirect_to request.referrer
  end
end
