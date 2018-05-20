class UserOrderEmailWorker
  include Sidekiq::Worker

  def perform(id)
    order = Order.find(id)
    order.send_confirmation_email
  end
end
