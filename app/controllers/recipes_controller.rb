class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  def show
    @recipe = Recipe.find(params[:id])
  end

  def index

  end

  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.build
    @recipe.recipe_products.build
    @ingredients = Ingredient.all
    @products = Product.all
    @ingredient = Ingredient.new
  end

  def create
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

  end

  def update

  end

  def destroy

  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, 
                                   :image, 
                                   :description, 
                                   :method, 
                                   :user_id, 
                                   recipe_ingredients_attributes: [:id, :quantity, :ingredient_id],
                                   recipe_products_attributes: [:id, :product_id])
  end
end
