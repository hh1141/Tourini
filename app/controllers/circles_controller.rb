class CirclesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_circle, only: [:show, :edit, :update, :destroy]

  def index
    @circles = current_user.circles.all.order('created_at DESC').page(params[:page]).per(8)
  end 

  def new
    @circle = current_user.circles.build
  end 

  def create
    @circle = current_user.circles.build(circle_params)
    if @circle.save
      redirect_to :back
    else
      render 'new'
    end 
  end

  def show
  end 

  def edit
  end 

  def update
    if @circle.update(circle_params)
      redirect_to @circle
    else 
      render 'edit'
    end 
  end 

  def destroy
    @circle.destroy

    redirect_to circles_path
  end 

  private

  def find_circle
    @circle = current_user.circles.find(params[:circle_name])
  end 

  def circle_params
    params.require(:circle).permit(:circle_id)
  end 
end
