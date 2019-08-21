class Feedback < ApplicationRecord
  belongs_to :user, required: false
  validates :description, presence: true
end
