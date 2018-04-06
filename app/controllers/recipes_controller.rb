class RecipesController < ApplicationController
  # Vulnerable at the moment - move new, create, edit, update, destroy to admin controller
  def show
    @recipe   = Recipe.friendly.find(params[:id])
    @comment  = RecipeComment.new
    @comments = @recipe.recipe_comments.all
    # unless @recipe.instagram_hashtag.blank?
    #   @instas   = InstagramApi.tag(@recipe.instagram_hashtag).recent_media
    # end

    if user_signed_in?
      current_user.viewed_recipes << @recipe
    end
    # negated sign to reverse array as it automatically sorts in ascending order
    @most_viewed_recipes = Recipe.all.sort_by{|recipe| -recipe.user_recipe_views.size}.first(5)
  end

  def index
    @recipes = Recipe.all
    @tags = Recipe.tag_counts_on(:rtags)
    @featured_recipes = Recipe.where(featured: true)
  end

  def tag
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:tag])
    @tags = Recipe.tag_counts_on(:rtags)
    @recipes = Recipe.tagged_with(@tag)
  end
end
