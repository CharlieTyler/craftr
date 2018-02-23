class RecipesController < ApplicationController
  before_action :authenticate_is_author, only: [:new, :create, :edit, :update, :destroy]
  def show
    @recipe = Recipe.find(params[:id])
    @comment = RecipeComment.new
    @comments = @recipe.recipe_comments.all
  end

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.build
    @recipe.recipe_products.build
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
    @recipe = Recipe.find(params[:id])
    unless @recipe.user == current_user
      return render text: 'Not Allowed', status: :forbidden
    end
    @recipe.recipe_ingredients.build
    @recipe.recipe_products.build
    @ingredients = Ingredient.all
    @products = Product.all
    @categories = Category.all
    @ingredient = Ingredient.new
  end

  def update
    @recipe = Recipe.find(params[:id])
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
                                   :category,
                                   :blurb,
                                   :variants,
                                   :image, 
                                   :banner_image,
                                   :description, 
                                   :method, 
                                   :user_id, 
                                   recipe_ingredients_attributes: [:id, :quantity, :ingredient_id, :recipe_id],
                                   recipe_products_attributes: [:id, :product_id, :recipe_id])
  end
end
