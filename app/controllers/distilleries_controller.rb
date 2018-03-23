class DistilleriesController < ApplicationController
  def index
    @distilleries = Distillery.all
  end

  def show
    @distillery = Distillery.friendly.find(params[:id])
    # unless @distillery.instagram_user_id.blank?
    #   @instas     = InstagramApi.user(@distillery.instagram_user_id).recent_media
    # end
  end
end
