class DistilleriesController < ApplicationController
  def index
    @distilleries = Distillery.live
  end

  def show
    @distillery = Distillery.friendly.find(params[:id])
    if @distillery.is_test
      unless user_signed_in? && current_user.admin
        flash[:notice] = "You are not permitted to view test products - please log in to an admin account"
        redirect_to distilleries_path
      end
    end
    # unless @distillery.instagram_user_id.blank?
    #   @instas     = InstagramApi.user(@distillery.instagram_user_id).recent_media
    # end
  end
end
