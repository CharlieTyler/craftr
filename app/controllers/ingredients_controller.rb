class IngredientsController < ApplicationController
  def create
    @ingredient = Ingredient.create(ingredient_params)
    if @ingredient.valid?
      redirect_to new_recipe_path
    else
      render "recipes/new", status: :unprocessable_entity
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
    @categories = Category.all
    @products = Product.all
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    @ingredient.update_attributes(ingredient_params)
    if @ingredient.valid?
      flash[:alert] = "Ingredient successfully created"
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name, 
                                       :classification,
                                       :category_id,
                                       :product_id,
                                       :image)
  end
end
