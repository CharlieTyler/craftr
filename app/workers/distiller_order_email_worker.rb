class DistillerOrderEmailWorker
  include Sidekiq::Worker

  def perform(id)
    order = Order.find(id)
    order.send_distiller_emails
  end
end
