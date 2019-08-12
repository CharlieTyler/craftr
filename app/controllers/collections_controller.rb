class CollectionsController < ApplicationController
  def show
    @all_collections = Collection.all
    @collection = Collection.friendly.find(params[:id])
    @products   = @collection.products
    @page_description          = @collection.description
  end
end
