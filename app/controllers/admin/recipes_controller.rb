class Admin::RecipesController < AdminController
  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.build
    @recipe.recipe_products.build
    @recipe.recipe_categories.build

    @authors = Author.order("name ASC")
    @ingredients = Ingredient.order("name ASC")
    @products = Product.order("name ASC")
    @categories = Category.order("name ASC")
    @ingredient = Ingredient.new
  end

  def create
    # Note: currently has to have recipe_ingredients and recipe_products
    @recipe = Recipe.create(recipe_params)
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

    @authors = Author.order("name ASC")
    @ingredients = Ingredient.order("name ASC")
    @products = Product.order("name ASC")
    @categories = Category.order("name ASC")
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
    @recipe = Recipe.friendly.find(params[:id])
    @recipe.delete
    flash[:alert] = "Recipe successfully deleted"
    redirect_to root_path
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
                                   :prep_time_in_minutes,
                                   recipe_ingredients_attributes: [:id, :quantity, :ingredient_id, :recipe_id],
                                   recipe_categories_attributes: [:id, :category_id, :recipe_id],
                                   recipe_products_attributes: [:id, :product_id, :recipe_id])
  end
end
