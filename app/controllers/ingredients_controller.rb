class IngredientsController < ApplicationController
  def create
    @ingredient = Ingredient.create(ingredient_params)
    if @ingredient.valid?
      redirect_to new_recipe_path
    else
      render "recipes/new", status: :unprocessable_entity
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, 
                                       :classification,
                                       :category_id,
                                       :product_id,
                                       :image)
  end
end
