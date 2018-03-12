class Admin::CategoriesController < AdminController
  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category.valid?
      redirect_to category_path(@category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.friendly.find(params[:id])
  end

  def update
    @category = Category.friendly.find(params[:id])
    @category.update_attributes(category_params)
    if @category.valid?
      redirect_to category_path(@category)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private

  def category_params
    params.require(:category).permit(:name, 
                                     :icon,
                                     :banner_image,
                                     :instagram_hashtag)
  end
end
