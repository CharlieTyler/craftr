class Distiller::StaticPagesController < DistillersController
  def dashboard
    @distillery = current_user.distillery
    @products = @distillery.products
  end
end
