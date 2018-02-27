class DistilleriesController < ApplicationController
  def index
    @distilleries = Distillery.all
  end

  def show
    @distillery = Distillery.find(params[:id])
    # @instas     = InstagramApi.user(@distillery.instagram_username).recent_media
  end
end
