class Admin::ColorsController < ApplicationController
  before_action :authenticate_admin!

  def create
    @color = Color.new(color_params)
    if @color.save
      flash[:notice] = 'You could create the new color.'
    else
      flash[:alert] = "You have to enter the all !!"
      redirect_to admin_colors_path
    end
  end

  def index
    @colors = Color.all
    @color = Color.new
  end
  
  def edit
    @color = Color.find(params[:id])
  end
  
  def update
    color = Color.find(params[:id])
    if color.update(color_params)
      flash[:notice] = 'You could update the color.'
    else
      flash[:alert] = 'You have to enter the all !!'
      redirect_to admin_colors_path
    end
  end

  def destroy
    @color = Color.find(params[:id])
    @color.destroy
    flash[:notice] = 'You could delete the color.'
    redirect_to admin_colors_path
  end

  private

  def color_params
    params.require(:color).permit(:name, :code)
  end

end
