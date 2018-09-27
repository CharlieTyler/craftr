class Admin::ProductsController < AdminController
  def new
    @product      = Product.new
    @product_images = @product.product_images.build
    @distilleries = Distillery.order("name ASC")
    @categories   = Category.order("name ASC")
  end

  def create
    @product = Product.create(product_params)
    if @product.valid?
      redirect_to product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.friendly.find(params[:id])
    @product_images  = @product.product_images.build
    @distilleries = Distillery.order("name ASC")
    @categories = Category.order("name ASC")
  end

  def update
    @product = Product.friendly.find(params[:id])
    @product.update_attributes(product_params)
    if @product.valid?
      redirect_to product_path(@product)
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.friendly.find(params[:id])
    @product.delete
    flash[:alert] = "Product successfully deleted"
    redirect_to root_path
  end

  private

  def product_params
    params.require(:product).permit(:name, 
                                    :is_live,
                                    :is_test,
                                    :is_in_stock,
                                    :weight,
                                    :price,
                                    :distillery_take,
                                    :description_short, 
                                    :description_first, 
                                    :description_second,
                                    :size_ml,
                                    :alcohol_percentage,
                                    :distillery_id,
                                    :category_id,
                                    :dry_to_sweet,
                                    :subtle_to_intense,
                                    :fresh_to_complex,
                                    product_images_attributes: [:id, :product_id, :photo])
  end
end
