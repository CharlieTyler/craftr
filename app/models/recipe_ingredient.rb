class RecipeIngredient < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  include RankedModel
  ranks :row_order, with_same: :recipe_id

  def quantity_and_name
    "#{quantity} #{ingredient.name}"
  end
end
