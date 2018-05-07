class OrderNotifierMailer < ApplicationMailer
  default :from => 'orders@craftr.co.uk'

  def user_confirmation_email(order)
    @order = order
    @user = order.user
    mail( :to => @user.email,
    :subject => 'Order confirmed - craft spirits inbound!' )
  end
end
