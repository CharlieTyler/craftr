class AgeVerificationController < ApplicationController
  respond_to :js

  def create
    # Should only get here if user not logged in
    session[:age_verified] = true 
  end
end
