class Admin::CarouselFeaturesController < AdminController
  def new
    @carousel_feature = CarouselFeature.new
  end

  def create
    @carousel_feature = CarouselFeature.create(carousel_feature_params)
    if @carousel_feature.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @carousel_feature = CarouselFeature.find(params[:id])
  end

  def update
    @carousel_feature = CarouselFeature.find(params[:id])
    @carousel_feature.update_attributes(carousel_feature_params)
    if @carousel_feature.valid?
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @carousel_feature = CarouselFeature.find(params[:id])
    @carousel_feature.delete
    flash[:alert] = "Carousel feature successfully deleted"
    redirect_to root_path
  end

  private

  def carousel_feature_params
    params.require(:carousel_feature).permit(:line_1,
                                             :line_2,
                                             :cta_text,
                                             :link_url,
                                             :image)
  end
end
