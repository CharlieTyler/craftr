class Admin::UsersController < AdminController
  def index
    # Will need to implement a search function here at some point
    @users = User.order('created_at DESC')
  end

  def edit
    @distilleries = Distillery.all
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(distillery_user_params)
    if @user.valid?
      flash[:notice] = "User now has access to distiller portal"
      redirect_to admin_dashboard_path
    else 
      return render :edit, status: :unprocessable_entity
    end
  end

  private

  def distillery_user_params
    params.require(:user).permit(:distillery_id,
                                 :age_verified
                                 # Just in case they haven't verified, would make it impossible to update 
                                 )
  end
end
