class EmailSignUp < ApplicationRecord
  after_create :queue_welcome_email
  validates_format_of :email, :with => /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/

  def queue_welcome_email
    EmailSignUpNotifierWorker.perform_async(id)
  end

  def send_welcome_email
    MailingListMailer.welcome_email(self).deliver_now
  end
end
