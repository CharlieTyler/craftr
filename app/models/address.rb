class Address < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :distillery, required: false

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :line_1, presence: true
  validates :post_town, presence: true
  validates :postcode, presence: true
  validates :easypost_address_id, presence: true
  validate :postcode_is_valid_postcode

  # copied from https://gist.github.com/mudge/163332
  def postcode_is_valid_postcode
    unless !!(postcode =~ /^\s*((GIR\s*0AA)|((([A-PR-UWYZ][0-9]{1,2})|(([A-PR-UWYZ][A-HK-Y][0-9]{1,2})|(([A-PR-UWYZ][0-9][A-HJKSTUW])|([A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY]))))\s*[0-9][ABD-HJLNP-UW-Z]{2}))\s*$/i)
      errors.add(:postcode, "Please enter a valid postcode")
    end
  end

  def full_address_no_name
    [line_1, line_2, line_3, post_town, postcode].join(", ")
  end

  def full_name
    [first_name, last_name].join(" ")
  end
end
