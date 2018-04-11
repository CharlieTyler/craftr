class EmailSignUpsController < ApplicationController
  def create
    @email_sign_up = EmailSignUp.create(email_sign_up_params)
    if @email_sign_up.valid?
      flash[:notice] = "Successfull signed up with #{@email_sign_up.email}"
      redirect_to request.referrer
    else
      flash[:alert] = "#{@email_sign_up.email} is not a valid email, please try again"
      redirect_to request.referrer
    end
  end

  def destroy
    # Note, this would mean that anyone could delete anyone's sign up. Unsure how to handle this
    @email_sign_up = EmailSignUp.find(params[:id])
    @email_sign_up.delete
  end

  private

  def email_sign_up_params
    params.require(:email_sign_up).permit(:email)
  end
end
