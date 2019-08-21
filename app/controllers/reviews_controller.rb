class ReviewsController < ApplicationController
  def create
    @product = Product.friendly.find(params[:product_id])
    @review  = @product.reviews.create(review_params.merge(user: current_user, verified: (current_user.previously_purchased_products.present? ? current_user.previously_purchased_products.include?(@product) : false)))
    if @review.valid?
      redirect_to product_path(@product)
    else
      flash[:alert] = "Please fill in both parts of the review form"
      redirect_to product_path(@product)
    end
  end

  def update

  end

  def destroy
    @review = Review.find(params[:id])
    @product = @review.product
    if @review.user == current_user
      @review.delete
      flash[:alert] = "Review successfully deleted. Please consider leaving a new one!"
    else
      flash[:alert] = "You may only delete your own reviews!"
    end
    redirect_to product_path(@product)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :message, :user_id, :product_id)
  end
end
