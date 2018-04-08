class RecipeCommentsController < ApplicationController
  def create
    @recipe = Recipe.friendly.find(params[:recipe_id])
    @recipe.recipe_comments.create(recipe_comment_params.merge(user: current_user))
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe_comment = RecipeComment.find(params[:id])
    @recipe_comment.delete
    flash[:alert] = "Comment deleted"
    redirect_to root_path
  end

  private

  def recipe_comment_params
    params.require(:recipe_comment).permit(:message, :recipe_id)
  end
end
