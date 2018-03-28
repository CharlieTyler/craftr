class Admin::ProductsController < AdminController
  def new
    @product      = Product.new
    @product_images = @product.product_images.build
    @distilleries = Distillery.all
    @categories   = Category.all
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
    @distilleries = Distillery.all
    @categories = Category.all
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

  end

  private

  def product_params
    params.require(:product).permit(:name, 
                                    :SKU, 
                                    :price,
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
