class RecipesController < ApplicationController
  before_action :authenticate_is_author, only: [:new, :create, :edit, :update, :destroy]
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
  end

  def tag
    @tag = ActsAsTaggableOn::Tag.friendly.find(params[:tag])
    @tags = Recipe.tag_counts_on(:rtags)
    @recipes = Recipe.tagged_with(@tag)
  end

  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.build
    @recipe.recipe_products.build
    @recipe.recipe_categories.build

    @authors = Author.all
    @ingredients = Ingredient.all
    @products = Product.all
    @categories = Category.all
    @ingredient = Ingredient.new
  end

  def create
    # Note: currently has to have recipe_ingredients and recipe_products
    @recipe = current_user.recipes.create(recipe_params)
    if @recipe.valid?
      redirect_to recipe_path(@recipe)
    else
      # Have to tell the template what the other model on the page is as well
      # Note: currently renders nested attributes as ids rather than names
      @ingredient = Ingredient.new
      return render :new, status: :unprocessable_entity
    end
  end

  def edit
    @recipe = Recipe.friendly.find(params[:id])
    unless @recipe.author == current_user
      return render text: 'Not Allowed', status: :forbidden
    end
    @recipe.recipe_ingredients.build
    @recipe.recipe_products.build
    @recipe.recipe_categories.build

    @ingredients = Ingredient.all
    @products = Product.all
    @categories = Category.all
    @ingredient = Ingredient.new
  end

  def update
    @recipe = Recipe.friendly.find(params[:id])
    @recipe.update_attributes(recipe_params)
    if @recipe.valid?
      redirect_to recipe_path(@recipe)
    else
      # Have to tell the template what the other model on the page is as well
      # Note: currently renders nested attributes as ids rather than names
      @ingredient = Ingredient.new
      return render :new, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, 
                                   :rtag_list,
                                   :blurb,
                                   :variants,
                                   :image, 
                                   :banner_image,
                                   :description, 
                                   :method, 
                                   :author_id, 
                                   :instagram_hashtag,
                                   recipe_ingredients_attributes: [:id, :quantity, :ingredient_id, :recipe_id],
                                   recipe_categories_attributes: [:id, :category_id, :recipe_id],
                                   recipe_products_attributes: [:id, :product_id, :recipe_id])
  end
end
