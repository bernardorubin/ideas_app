class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_idea

  def create
    @idea.likes += 1
    if @idea.save
      redirect_to ideas_path, notice: 'Idea Liked!'
    else
      render :edit
    end
  end

  private

  def find_idea
    @idea = Idea.find params[:idea_id]
  end
end
