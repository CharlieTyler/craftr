class AdminOrderEmailWorker
  include Sidekiq::Worker

  def perform(*args)
    order = Order.find(id)
    order.send_admin_emails
  end
end
