class OrderNotifierMailer < ApplicationMailer
  default :from => 'orders@craftr.co.uk'

  def user_confirmation_email(order)
    @order = order
    @user = order.user
    mail( :to => @user.email,
    :subject => 'Order confirmed - craft spirits inbound!' )
  end

  def distiller_confirmation_email(si)
    @sold_item = si
    @distillery = si.product.distillery
    @user = @distillery.users.first
    mail( :to => @user.email,
      :subject => "#{si.quantity} * #{si.product.name} orderd on Craftr")
  end

  def user_review_email(order)
    @order = order
    @user = order.user
    mail( :to => @user.email,
    :subject => "How about a trade... recipes for a review?" )
  end
end
