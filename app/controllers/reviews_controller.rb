class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    review_params    = params.require(:review).permit(:body)
    @review          = Review.new review_params
    @idea = Idea.find params[:idea_id]
    @review.idea = @idea
    @review.user = current_user
    if @review.save
      redirect_to idea_path(params[:idea_id]), notice: 'Review Created!'
    else
      flash[:alert] = 'Please Fix Errors'
      render 'ideas/show'
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to idea_path(@review.idea_id), notice: 'Review Deleted!'
  end

end
