class UserRecipeView < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :recipe, counter_cache: true
end
