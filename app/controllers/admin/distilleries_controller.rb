class Admin::DistilleriesController < AdminController
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
    @distillery = Distillery.friendly.find(params[:id])
  end

  def update
    @distillery = Distillery.friendly.find(params[:id])
    @distillery.update_attributes(distillery_params)
    if @distillery.valid?
      redirect_to distillery_path(@distillery)
    else
      return render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @distillery = Distillery.friendly.find(params[:id])
    @distillery.delete
    flash[:alert] = "Distillery successfully deleted"
    redirect_to root_path
  end

  private

  def distillery_params
    params.require(:distillery).permit(:name,
                                       :is_live,
                                       :is_test,
                                       :location, 
                                       :logo,
                                       :youtube_video_url,
                                       :summary_text, 
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
                                       :instagram_user_id,
                                       :longitude,
                                       :latitude
                                       )
  end
end
