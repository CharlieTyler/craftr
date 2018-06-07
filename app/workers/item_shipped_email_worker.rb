class ItemShippedEmailWorker
  include Sidekiq::Worker

  def perform(id)
    si = SoldItem.find(id)
    si.send_shipped_email
  end
end
