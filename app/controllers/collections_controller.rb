class CollectionsController < ApplicationController
  def show
    @collection = Collection.friendly.find(params[:id])
    @other_collections = Collection.where.not(id: @collection.id)
    @featured_products = @collection.collection_products.where(featured: true).map{ |cp| cp.product }
    @non_featured_products   = @collection.collection_products.where(featured: [nil, false]).shuffle.map{ |cp| cp.product }
    @page_description          = @collection.description
  end

  def index
    @collections = Collection.all
  end
end
