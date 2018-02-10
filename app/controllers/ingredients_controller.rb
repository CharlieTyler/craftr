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
    params.require(:ingredient).permit(:name, :categorisation, :category_id)
  end
end
