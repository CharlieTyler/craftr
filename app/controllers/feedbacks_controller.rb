class FeedbacksController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.create(feedback_params)
    if @feedback.valid?
      flash[:notice] = "Thank you for your feedback - we'll get working on it!"
      redirect_to root_path
    else
      flash[:alert] = "Please make sure you've filled in all required fields"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.delete
    flash[:alert] = "Feedback successfully deleted"
    redirect_to root_path
  end

  private

  def feedback_params
    params.require(:feedback).permit(:email,
                                     :user_id,
                                     :description,
                                     :url
                                     )
  end
end
