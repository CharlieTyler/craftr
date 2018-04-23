class Order < ApplicationRecord
  has_many :order_items
  has_one :sale
  after_commit :create_sale, if: :order_paid_and_not_denormalised, on: :update
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
    shipping_type.price * total_quantity
  end

  def total_amount
    total_product_amount + total_shipping_amount
  end

  def create_shipments
    order_items.each do |oi|
      oi.quantity.times do
        parcel       = EasyPost::Parcel.create(
                        predefined_package: 'SmallParcel',
                        weight: 35
                       )
        toAddress   = EasyPost::Address.retrieve(shipping_address.easypost_address_id)
        fromAddress = EasyPost::Address.retrieve(oi.product.distillery.address.easypost_address_id)
        shipment     = EasyPost::Shipment.create(
                        to_address: toAddress,
                        from_address: fromAddress,
                        parcel: parcel,
                        options: {alcohol: true}
                       )
        shipment.buy(
          rate: shipment.lowest_rate(carriers = ['RoyalMail'], services = ['2ndClassSignedFor'])
        )
      end
    end
  end

  def order_paid_and_not_denormalised
    state == "paid" && sale.blank?
  end

  def create_sale
    sale = Sale.create(order_id: self.id, user_id: self.user.id)
    sale.save!
    order_items.each do |oi|
      sale.sale_items.create(product_id: oi.product.id, order_item_id: oi.id, quantity: oi.quantity, item_price: oi.product.price, status: "Awaiting shipping")
    end
  end
end
