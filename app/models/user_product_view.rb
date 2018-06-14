class UserProductView < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :product, counter_cache: true
end
