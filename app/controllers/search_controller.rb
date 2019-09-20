class SearchController < ApplicationController
  def search
    matched_products = Product.where('lower(name) = ?', params[:keyword].downcase)
    if matched_products.length > 0
      redirect_to product_path(matched_products.first)
    end

    matched_categories = Category.where('lower(name) = ?', params[:keyword].downcase)
    if matched_categories.length > 0
      redirect_to category_path(matched_categories.first)
    end

    @suggested_products = Product.transactional.where(featured: true).sample(4)
    @results = Search.new(params).results
    @keyword = params[:keyword]
    # FOR PAGINATION
    # @results = {}
    # Search.new(params).results_combined.each do |result|
    #  if result.is_a?(Product)
    #    @results[:products] ||= []
    #    @results[:products] << result
    #  elsif false
    #  end  
  end

  private
end