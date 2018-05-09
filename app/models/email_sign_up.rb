class EmailSignUp < ApplicationRecord
  after_create :send_welcome_email
  validates_format_of :email, :with => /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/

  def send_welcome_email
    MailingListMailer.welcome_email(self).deliver_now
  end
end
