class Admin::RecipesController < AdminController
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
    @recipe = Recipes.create(recipe_params)
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
    @recipe.recipe_ingredients.build
    @recipe.recipe_products.build
    @recipe.recipe_categories.build

    @authors = Author.all
    @ingredient = Ingredient.new
    @ingredients = Ingredient.all
    @products = Product.all
    @categories = Category.all
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
    @recipe = Recipe.friendly.find(params[:id])
    @recipe.delete
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name,
                                   :rtag_list,
                                   :blurb,
                                   :author_id,
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
