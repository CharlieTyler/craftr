class MailingListMailer < ApplicationMailer
  default :from => 'newsletters@craftr.co.uk'

  def welcome_email(email_sign_up)
    @email = email_sign_up.email
    mail( :to => @email,
    :subject => 'Welcome to Craftr... Deliciousness awaits!' )
  end
end
