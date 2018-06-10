class DistillerOrderEmailReminderWorker
  include Sidekiq::Worker

  def perform(id)
    order = Order.find(id)
    order.send_distiller_reminder_emails_if_not_shipped
  end
end
