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
    @category = Category.friendly.find(params[:id])
    @category.delete
    flash[:alert] = "Category successfully deleted"
    redirect_to root_path
  end

  private

  def category_params
    params.require(:category).permit(:name,
                                     :description,
                                     :icon,
                                     :banner_image,
                                     :featured,
                                     :instagram_hashtag,
                                     :gradient_from,
                                     :gradient_to,
                                     :row_order_position)
  end
end
