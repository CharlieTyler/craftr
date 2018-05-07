class Order < ApplicationRecord
  has_many :order_items
  has_many :sold_items
  belongs_to :shipping_type, required: false
  belongs_to :shipping_address, class_name: 'Address', foreign_key: 'shipping_address_id', required: false
  belongs_to :user, required: false
  # validate :addresses_belongs_to_order_user

  def addresses_belongs_to_order_user
    shipping_address.user == user
  end

  def total_quantity
    order_items.sum(&:quantity)
  end

  def total_product_amount
    order_items.to_a.sum(&:subtotal_in_pence)
  end

  def total_shipping_amount
    shipping_type.price
  end

  def total_amount
    total_product_amount + total_shipping_amount
  end

  def denormalise_order
    update_attributes(paid_shipping_price: total_shipping_amount)
    order_items.each do |oi|
      self.sold_items.create(order_id: self.id, 
                             product_id: oi.product.id, 
                             order_item_id: oi.id, 
                             quantity: oi.quantity, 
                             item_price: oi.product.price, 
                             distillery_take: oi.product.distillery_take, 
                             status: "Awaiting shipping")
    end
  end

  def create_shipments
    sold_items.each do |si|
      # Look into whether a product can fit 2 products in a Small Parcel
      si.quantity.times do
        parcel       = EasyPost::Parcel.create(
                        predefined_package: 'Parcel',
                        weight: si.product.weight
                       )
        toAddress   = EasyPost::Address.retrieve(shipping_address.easypost_address_id)
        fromAddress = EasyPost::Address.retrieve(si.product.distillery.address.easypost_address_id)
        shipment     = EasyPost::Shipment.create(
                        to_address: toAddress,
                        from_address: fromAddress,
                        parcel: parcel,
                        options: {alcohol: true}
                       )
        shipment.buy(
          rate: shipment.lowest_rate(carriers = ['USPS'], services = ['First'])
          # (carriers = ['RoyalMail'], services = ['2ndClassSignedFor']) leaving until Royal Mail account present
        )
        Postage.create(postage_label_url: shipment.postage_label.label_url, tracking_code: shipment.tracking_code, sold_item_id: si.id)
      end
    end
  end
end
