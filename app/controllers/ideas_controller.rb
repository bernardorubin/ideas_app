class IdeasController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action(:find_idea, { only: [:show, :edit, :destroy, :update] })

  def index
    @ideas = Idea.order(created_at: :desc)
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    @idea.user = current_user
    if @idea.save
      flash[:notice] = 'Idea Created Perfectly'
      redirect_to idea_path(@idea)
    else
      flash.now[:alert] = 'Please Fix Errors Below'
      render :new
    end
  end

  def edit
  end

  def update
    if @idea.update idea_params
      redirect_to ideas_path, notice: 'Idea Updated!'
    else
      render :edit
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_path, notice: 'Idea Deleted!'
  end

  def show
    @review = Review.new
  end

  private

  def find_idea
    @idea = Idea.find params[:id]
  end

  def idea_params
    params.require(:idea).permit([:title, :description])
  end
end
