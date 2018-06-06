class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :age_verified, :privacy_policy_accepted, :newsletter_sign_up)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :age_verified, :privacy_policy_accepted, :newsletter_sign_up, :current_password)
  end
end