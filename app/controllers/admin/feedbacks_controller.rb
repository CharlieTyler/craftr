class Admin::FeedbacksController < ApplicationController
  def update
    @feedback = Feedback.find(params[:id])
    @feedback.update_attributes(feedback_params)
    if @feedback.valid?
      redirect_to admin_dashboard_path
    else
      return render :new, status: :unprocessable_entity
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:done)
  end
end
