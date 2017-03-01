class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_like, only: [:destroy]
  before_action :find_idea, only: [:create]

  # def index
  #     @user = User.find(params[:user_id])
  #     @ideas = @user.liked_ideas
  # end

  def create
    like = Like.new(user: current_user, idea: @idea)

    if cannot? :like, @idea
      redirect_to idea_path(@idea), alert: 'Liking your own idea isn\'t allowed'
      return
    end

    if like.save
      redirect_to ideas_path, notice: 'Idea liked! 👍'
    else
      redirect_to ideas_path, alert: 'Couldn\'t like idea 🤙'
    end
  end

  def destroy
    if cannot? :like, @like.idea
      redirect_to ideas_path, alert: 'Un-Liking your own idea isn\'t allowed'
      return
    end
    redirect_to(
      ideas_path,
      @like.destroy ? {notice: 'Idea Un-liked 👎'} : {alert: @like.errors.full_messages.join(', ')}
    )
  end

  private

  def find_like
    @like ||= Like.find(params[:id])
  end
  def find_idea
    @idea ||= Idea.find(params[:idea_id])
  end
end
