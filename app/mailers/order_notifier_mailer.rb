class OrderNotifierMailer < ApplicationMailer
  default :from => 'Craftr Orders <orders@craftr.co.uk>'

  include ActionView::Helpers::TextHelper

  def abandoned_basket_email(order)
    @order = order
    @user = @order.user
    @order_items = @order.order_items
    mail( :to => @user.email,
      :subject => "Oh no! You've left #{pluralize(@order.total_unpaid_quantity, 'lonely craft spirit')} behind!")
  end

  def user_confirmation_email(order)
    @order = order
    @user = order.user
    mail( :to => @user.email,
    :subject => 'Order confirmed - craft spirits inbound!' )
  end

  def admin_email(order, admin)
    @order = order
    @user_email = order.user.email
    @orders_in_last_30_days = Order.where("(updated_at > ? AND paid = ?)", Time.zone.today-30.days, true)
    mail( :to => admin, :subject => "New order")
    # admin is the argument passed 
  end

  def distiller_confirmation_email(si, user)
    @sold_item = si
    @address = si.order.shipping_address
    @distillery = si.product.distillery
    @user = user
    mail( :to => @user.email,
      :subject => "#{si.quantity} * #{si.product.name.titleize} ordered on Craftr")
  end

  def item_shipped_email(si)
    @sold_item = si
    @distillery = si.product.distillery
    @order = si.order_item.order
    @address = @order.shipping_address
    @recipient = @order.user
    mail( :to => @recipient.email,
      :subject => "#{@distillery.name} have shipped #{si.quantity} * #{si.product.name.titleize} to you!")
  end

  def distiller_reminder_email(si)
    @sold_item = si
    @distillery = si.product.distillery
    @user = @distillery.users.first
    mail( :to => @user.email,
      :subject => "REMINDER: Please ship #{si.quantity} * #{si.product.name.titleize} soon!")
  end

  def user_review_email(order)
    @order = order
    @user = order.user
    mail( :to => @user.email,
    :subject => "How about a trade... recipes for a review?" )
  end
end
