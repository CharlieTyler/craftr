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

  def is_in_date_and_live
    valid_to > Time.now.in_time_zone('London') && valid_from < Time.now.in_time_zone('London') && live 
  end
end
