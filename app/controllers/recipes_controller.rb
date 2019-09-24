class RecipesController < ApplicationController
  # Vulnerable at the moment - move new, create, edit, update, destroy to admin controller
  def show
    @recipe   = Recipe.friendly.find(params[:id])
    UserRecipeView.create(user: user_signed_in? ? current_user : nil, recipe: @recipe)
    @comment  = RecipeComment.new
    @comments = @recipe.recipe_comments.all
    @page_description          = @recipe.seo_description
    @page_keywords             = @recipe.seo_keywords
    @page_image_src            = @recipe.image_url
    @same_author_recipes       = Recipe.where(author_id: @recipe.author.id).where.not(id: @recipe.id).sample(4)
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
    @recipes = Recipe.page(params[:page]).order('created_at DESC')
    @all_recipes = Recipe.all
    @tags = Recipe.tag_counts_on(:rtags)
    @featured_recipes = Recipe.where(featured: true)
    @page_description          = "Recipes for beautiful cocktails using craft spirits from CRAFTR. See #{@all_recipes.length} recipes from craft distilleries, bloggers and enthusiasts."
    @page_keywords             = "craft, spirits, recipes, cocktail, #{category_list}"
  end

  def tag
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:tag])
    @tags = Recipe.tag_counts_on(:rtags)
    @recipes = Recipe.tagged_with(@tag)
  end
end
