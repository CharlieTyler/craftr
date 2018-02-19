class Admin::ProductsController < ApplicationController
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

  end

  def update

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
                                    :alcohol_percentage,
                                    :distillery_id,
                                    :category_id, 
                                    product_images_attributes: [:id, :photo])
  end
end
