class EmailSignUpNotifierWorker
  include Sidekiq::Worker

  def perform(id)
    user_email = EmailSignUp.find(id)
    user_email.send_welcome_email
  end
end
