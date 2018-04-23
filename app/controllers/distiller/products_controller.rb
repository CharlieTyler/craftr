class Distiller::ProductsController < DistillersController
  def edit
    @product = Product.friendly.find(params[:id])
  end

  def update
    @product = Product.friendly.find(params[:id])
    @product.update_attributes(distiller_product_params)
    if @product.valid?
      redirect_to product_path(@product)
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  private

  def distiller_product_params
    params.require(:product).permit(:is_live,
                                    :is_in_stock,
                                    :weight,
                                    :dry_to_sweet,
                                    :subtle_to_intense,
                                    :fresh_to_complex
                                    )
  end
end
