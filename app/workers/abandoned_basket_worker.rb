class AbandonedBasketWorker
  include Sidekiq::Worker

  def perform(id)
    order = Order.find(id)
    order.send_abandoned_basket_email
  end
end
