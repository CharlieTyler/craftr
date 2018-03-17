class Address < ApplicationRecord
  belongs_to :user, required: false
end
