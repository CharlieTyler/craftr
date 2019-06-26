class Voucher < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  has_many :orders
  validates :name, presence: true
  validates :code, presence: true
  validates :value, presence: true
  validates :valid_from, presence: true
  validates :valid_to, presence: true

  def human_readable_price
    number_to_currency((value.to_f / 100), unit: "£")
  end
end
