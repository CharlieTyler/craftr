class ReviewsController < ApplicationController
  def create
    @product = Product.friendly.find(params[:product_id])
    @review  = @product.reviews.create(review_params.merge(user: current_user))
    if @review.valid?
      redirect_to product_path(@product)
    else
      return render text: 'Invalid review', status: :unprocessable_entity
    end
  end

  def update

  end

  def destroy
    @review = Review.find(params[:id])
    @review.delete
  end

  private

  def review_params
    params.require(:review).permit(:rating, :message, :user_id, :product_id)
  end
end
