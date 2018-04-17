class Address < ApplicationRecord
  after_create :create_easypost_address

  belongs_to :user, required: false
  belongs_to :distillery, required: false

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :line_1, presence: true
  validates :post_town, presence: true
  validates :postcode, presence: true
  validate :postcode_is_valid_postcode

  # copied from https://gist.github.com/mudge/163332
  def postcode_is_valid_postcode
    unless !!(postcode =~ /^\s*((GIR\s*0AA)|((([A-PR-UWYZ][0-9]{1,2})|(([A-PR-UWYZ][A-HK-Y][0-9]{1,2})|(([A-PR-UWYZ][0-9][A-HJKSTUW])|([A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY]))))\s*[0-9][ABD-HJLNP-UW-Z]{2}))\s*$/i)
      errors.add(:postcode, "Please enter a valid postcode")
    end
  end

  def full_address_no_name
    [line_1, line_2, line_3, post_town, postcode].reject { |e| e.to_s.empty? }.join(", ")
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def create_easypost_address
    ep_address = EasyPost::Address.create(
      name: full_name,
      street1: line_1,
      street2: line_2,
      city: post_town,
      zip: postcode
    )
    update_attributes(easypost_address_id: ep_address.id)
  end
end
