# Preview all emails at http://localhost:3000/rails/mailers/order_notifier_mailer
class OrderNotifierMailerPreview < ActionMailer::Preview
  def abandoned_basket_email
    order = Order.where(paid: true).last
    OrderNotifierMailer.abandoned_basket_email(order)
  end

  def user_confirmation_email
    order = Order.where(paid: true).last
    OrderNotifierMailer.user_confirmation_email(order)
  end

  def admin_email
    order = Order.where(paid: true).last
    admin = User.where(admin: true).first
    OrderNotifierMailer.admin_email(order, admin)
  end

  def distiller_confirmation_email
    si = Order.where(paid: true).last.sold_items.first
    OrderNotifierMailer.distiller_confirmation_email(si)
  end

  def item_shipped_email
    si = Order.where(paid: true).last.sold_items.first
    OrderNotifierMailer.item_shipped_email(si)
  end

  def distiller_reminder_email
    si = Order.where(paid: true).last.sold_items.first
    OrderNotifierMailer.distiller_reminder_email(si)
  end

  def user_review_email
    order = Order.where(paid: true).last
    OrderNotifierMailer.user_review_email(order)
  end
end
