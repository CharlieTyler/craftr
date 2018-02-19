class DistilleriesController < ApplicationController
  def index

  end

  def show
    @distillery = Distillery.find(params[:id])
  end
end
