class Admin::AuthorsController < AdminController
  def new
    @author = Author.new
    @users = User.all
    @distilleries = Distillery.order("name ASC")
  end

  def create
    @author = Author.create(author_params)
    if @author.valid?
      redirect_to author_path(@author)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @author = Author.friendly.find(params[:id])
    @users = User.all
    @distilleries = Distillery.order("name ASC")
  end

  def update
    @author = Author.friendly.find(params[:id])
    @author.update_attributes(author_params)
    if @author.valid?
      redirect_to author_path(@author)
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @author = Author.friendly.find(params[:id])
    @author.delete
    flash[:alert] = "Author successfully deleted"
    redirect_to root_path
  end

  private

  def author_params
    params.require(:author).permit(:name,
                                   :location,
                                   :bio,
                                   :background_image,
                                   :mugshot,
                                   :instagram_link,
                                   :website_link,
                                   :slug,
                                   :user_id,
                                   :distillery_id,
                                   :bio_image)
  end
end
