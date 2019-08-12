class Admin::CollectionsController < ApplicationController
  def new
    @products = Product.order("name ASC")
    @categories = Category.order("name ASC")
    @collection = Collection.new

    @collection.collection_products.build
  end

  def create
    @collection = Collection.create(collection_params)
    if @collection.valid?
      redirect_to collection_path(@collection)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @products = Product.order("name ASC")
    @categories = Category.order("name ASC")
    @collection = Collection.friendly.find(params[:id])

    @collection.collection_products.build
  end

  def update
    @collection = Collection.friendly.find(params[:id])
    @collection.update_attributes(collection_params)
    if @collection.valid?
      redirect_to collection_path(@collection)
    else
      return render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @collection = Collection.friendly.find(params[:id])
    @collection.delete
    flash[:alert] = "Collection successfully deleted"
    redirect_to root_path
  end

  private

  def collection_params
    params.require(:collection).permit(:name,
                                       :description,
                                       :image,
                                       :category_id,
                                       collection_products_attributes: [:id, :collection_id, :product_id]
                                       )
  end
end
