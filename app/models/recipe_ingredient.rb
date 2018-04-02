class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  include RankedModel
  ranks :row_order, with_same: :recipe_id
end
