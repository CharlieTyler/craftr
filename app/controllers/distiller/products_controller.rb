class Distiller::ProductsController < DistillersController
  def edit
    @product = Product.friendly.find(params[:id])
  end

  def update
    @product = Product.friendly.find(params[:id])
    @product.update_attributes(distiller_product_params)
    if @product.valid?
      flash[:notice] = "#{@product.name} updated"
      redirect_to distiller_dashboard_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def mark_as_in_stock
    respond_to do |format|
      format.js
    end
    @product = Product.friendly.find(params[:id])
    @product.update_attributes(is_in_stock: true)
  end

  def mark_as_out_of_stock
    respond_to do |format|
      format.js
    end
    @product = Product.friendly.find(params[:id])
    @product.update_attributes(is_in_stock: false)
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
