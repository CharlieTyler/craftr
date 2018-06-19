class DistilleriesController < ApplicationController
  def index
    @distilleries = Distillery.live
    @page_description          = "Browse and buy craft spirits from #{@distilleries.length} different craft distilleries across the UK."
    @page_keywords             = "craft, distillery, distilleries, England, English, Scotland, Scottish, Wales, Welsh, Ireland, Irish, #{category_list.join(', ')}"
  end

  def show
    @distillery = Distillery.friendly.find(params[:id])

    @page_description          = @distillery.seo_description
    @page_keywords             = @distillery.seo_keywords
    if @distillery.is_test
      unless user_signed_in? && current_user.admin
        flash[:notice] = "You are not permitted to view test products - please log in to an admin account"
        redirect_to distilleries_path
      end
    end
  end
end
