class Admin::DistilleriesController < ApplicationController
  def new
    @distillery = Distillery.new
  end

  def create
    @distillery = Distillery.create(distillery_params)
    if @distillery.valid?
      redirect_to distillery_path(@distillery)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def distillery_params
    params.require(:distillery).permit(:name, :location, :description_short, :description_first, :description_second)
  end
end
