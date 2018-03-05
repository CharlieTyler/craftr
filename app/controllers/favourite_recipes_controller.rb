class FavouriteRecipesController < ApplicationController
  respond_to :js
  
  def create
    @recipe = Recipe.friendly.find(params[:recipe_id])
    current_user.favourite_recipes << @recipe
  end

  def destroy
    @recipe = Recipe.friendly.find(params[:recipe_id])
    current_user.favourite_recipes.delete(@recipe)
  end
end
