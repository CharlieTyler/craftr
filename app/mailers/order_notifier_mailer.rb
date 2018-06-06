class OrderNotifierMailer < ApplicationMailer
  default :from => 'orders@craftr.co.uk'

  def user_confirmation_email(order)
    @order = order
    @user = order.user
    mail( :to => @user.email,
    :subject => 'Order confirmed - craft spirits inbound!' )
  end

  def distiller_confirmation_email(oi)
    @order_item = oi
    @distillery = oi.product.distillery
    @user = @distillery.users.first
    mail( :to => @user.email,
      :subject => "#{oi.quantity} * #{oi.product.name} orderd on Craftr")
  end

  def user_review_email(order)
    @order = order
    @user = order.user
    mail( :to => @user.email,
    :subject => 'Craft spirits are [insert your thoughts here]' )
  end
end
