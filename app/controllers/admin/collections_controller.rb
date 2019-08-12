class Admin::CollectionsController < ApplicationController
  def new
    @products = Product.all
    @categories = Category.all
    @collection = Collection.new
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
    @products = Product.all
    @categories = Category.all
    @collection = Collection.friendly.find(params[:id])
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
                                       :category_id
                                       )
  end
end
