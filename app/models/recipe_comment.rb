class RecipeComment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :message, presence: true
end
