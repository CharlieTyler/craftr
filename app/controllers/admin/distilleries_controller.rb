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
    @distillery = Distillery.find(params[:id])
  end

  def update
    @distillery = Distillery.find(params[:id])
    @distillery.update_attributes(distillery_params)
    if @distillery.valid?
      redirect_to distillery_path(@distillery)
    else
      return render :new, status: :unprocessable_entity
    end
  end

  def destroy

  end

  private

  def distillery_params
    params.require(:distillery).permit(:name, 
                                       :location, 
                                       :description_short, 
                                       :description_first, 
                                       :description_second,
                                       :banner_image)
  end
end
