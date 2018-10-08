class Order < ApplicationRecord
  has_many :order_items
  has_many :sold_items
  belongs_to :shipping_type, required: false
  belongs_to :shipping_address, class_name: 'Address', foreign_key: 'shipping_address_id', required: false
  belongs_to :user, required: false
  # validate :address_belongs_to_order_user

  # Custom validations
  def address_belongs_to_order_user
    shipping_address.user == user
  end

  # General attribute methods
  def state
    if paid
      return "#{shipped_sold_items_length} of #{total_paid_quantity} products shipped"
    else
      return "upaid"
    end
  end

  def shipped_sold_items_length
    sold_items.where(shipped: true).sum(&:quantity)
  end

  # Attribute methods pre-denormalising
  def total_unpaid_quantity
    order_items.sum(&:quantity)
  end

  def total_unpaid_product_amount
    order_items.to_a.sum(&:subtotal_in_pence)
  end

  def total_unpaid_shipping_amount
    shipping_type.price
  end

  def total_unpaid_amount
    total_unpaid_product_amount + total_unpaid_shipping_amount
  end

  # Attribute methods post denormalising
  def total_paid_quantity
    sold_items.sum(&:quantity)
  end

  def total_paid_product_amount
    sold_items.to_a.sum(&:total_paid)
  end

  def total_paid_amount
    total_paid_product_amount + paid_shipping_price
  end

  def product_summary
    sold_items.map { |si| "#{si.quantity} * #{si.product.name}"}.join(", ")
  end

  # Emails
  def queue_confirmation_email
    UserOrderEmailWorker.perform_async(id)
  end

  def send_confirmation_email
    OrderNotifierMailer.user_confirmation_email(self).deliver_now    
  end

  def queue_admin_emails
    AdminOrderEmailWorker.perform_async(id)
  end

  def send_admin_emails
    ["mike@craftr.co.uk", "will@craftr.co.uk"].each do |admin|
      OrderNotifierMailer.admin_email(self, admin).deliver_now
    end
  end

  def queue_distiller_emails
    DistillerOrderEmailWorker.perform_async(id)
  end

  def send_distiller_emails
    sold_items.each do |si|
      OrderNotifierMailer.distiller_confirmation_email(si).deliver_now
    end
  end

  def queue_distiller_reminder_emails
    DistillerOrderEmailReminderWorker.perform_in(2.days, id)
  end

  def send_distiller_reminder_emails_if_not_shipped
    sold_items.each do |si|
      unless si.shipped
        OrderNotifierMailer.distiller_reminder_email(si).deliver_now
      end
    end
  end

  def queue_abandoned_basket_email
    AbandonedBasketWorker.perform_in(2.days, id)
  end

  def send_abandoned_basket_email
    if user.present? && order_items.present? && paid == false
      OrderNotifierMailer.abandoned_basket_email(self).deliver_now
    end
  end

  def queue_please_review_email
    UserPleaseReviewEmailWorker.perform_in(3.weeks, id)
  end

  def send_please_review_email
    OrderNotifierMailer.user_review_email(self).deliver_now
  end

  # Actions
  def denormalise_order
    update_attributes(paid_shipping_price: total_unpaid_shipping_amount)
    order_items.each do |oi|
      self.sold_items.create(order_id: self.id, 
                             product_id: oi.product.id, 
                             order_item_id: oi.id, 
                             quantity: oi.quantity, 
                             item_price: oi.product.price, 
                             distillery_take: oi.product.distillery_take
                             )
    end
  end

  def queue_shipment_creation
    CreateOrderShipmentsWorker.perform_async(id)
  end

  def create_shipments
    sold_items.each do |si|
      si.quantity.times do
        parcel       = EasyPost::Parcel.create(
                        predefined_package: 'SMALLPARCEL',
                        weight: si.product.weight
                       )
        toAddress   = EasyPost::Address.retrieve(shipping_address.easypost_address_id)
        fromAddress = EasyPost::Address.retrieve(si.product.distillery.address.easypost_address_id)
        shipment    = EasyPost::Shipment.create(
                        to_address: toAddress,
                        from_address: fromAddress,
                        parcel: parcel,
                        carrier_account_id: "ca_c3a3178260c54bac8e41f01df1340b14",
                        options: {alcohol: true}
                       )
        shipment.buy(
          rate: shipment.lowest_rate(carrier_accounts = ['RoyalMail'], service = ['RoyalMail2ndClass'])
          #  leaving until Royal Mail account present
        )
        si.postages.create(postage_label_url: shipment.postage_label.label_url, tracking_code: shipment.tracking_code, easypost_shipment_id: shipment.id)
      end
      si.update_attributes(shipping_label_created: true, shipping_label_created_at: Time.now.in_time_zone('London'))
    end
  end

  def merge_with(other_order)
    other_order.order_items.each do |ooi|
      if self.order_items.any? {|oi| oi.product_id == ooi.product_id }
        oi = self.order_items.where(product_id: ooi.product_id).first
        max_quantity = [oi.quantity, ooi.quantity].max
        oi.update_attributes(quantity: max_quantity)
      else
        self.order_items.create(product_id: ooi.product.id, quantity: ooi.quantity)
      end
    end
  end
end
