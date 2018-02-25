class DistilleriesController < ApplicationController
  def index
    @distilleries = Distillery.all
  end

  def show
    @distillery = Distillery.find(params[:id])
  end
end
