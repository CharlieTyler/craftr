class CollectionsController < ApplicationController
  def show
    @collection = Collection.friendly.find(params[:id])
    @other_collections = Collection.where.not(id: @collection.id)
    @products   = @collection.products
    @page_description          = @collection.description
  end

  def index
    @collections = Collection.all
  end
end
