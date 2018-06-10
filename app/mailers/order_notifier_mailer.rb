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

  def item_shipped_email(si)
    @sold_item = si
    @distillery = si.product.distillery
    @order = si.order_item.order
    @address = @order.shipping_address
    @recipient = @order.user
    mail( :to => @recipient.email,
      :subject => "#{@distillery.name} have shipped #{si.quantity} * #{si.product.name} to you!")
  end

  def distiller_reminder_email(si)
    @sold_item = si
    @distillery = si.product.distillery
    @user = @distillery.users.first
    mail( :to => @user.email,
      :subject => "REMINDER: Please ship #{si.quantity} * #{si.product.name} soon!")
  end

  def user_review_email(order)
    @order = order
    @user = order.user
    mail( :to => @user.email,
    :subject => "How about a trade... recipes for a review?" )
  end
end
