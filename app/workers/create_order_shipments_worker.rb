class CreateOrderShipmentsWorker
  include Sidekiq::Worker

  def perform(id)
    order = Order.find(id)
    order.create_shipments
  end
end
