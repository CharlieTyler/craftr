class SearchController < ApplicationController

   def search
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