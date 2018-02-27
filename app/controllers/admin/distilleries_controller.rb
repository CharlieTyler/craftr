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
                                       :sumamry_text, 
                                       :people_text, 
                                       :range_text,
                                       :summary_image,
                                       :people_image,
                                       :range_image,
                                       :blurb_1,
                                       :blurb_2,
                                       :blurb_3,
                                       :image_1,
                                       :image_2,
                                       :image_3,
                                       :website,
                                       :facebook,
                                       :instagram_username,
                                       :longitude,
                                       :latitude
                                       )
  end
end
