class Admin::ColorsController < ApplicationController
  before_action :authenticate_admin!

  def create
    @color = Color.new(color_params)
    @color.save
    flash[:notice] = 'CREATED'
    redirect_to admin_colors_path
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
    color.update(color_params)
    flash[:notice] = 'UPDATED'
    redirect_to admin_colors_path
  end

  def destroy
    @color = Color.find(params[:id])
    @color.destroy
    flash[:notice] = 'DELETED'
    redirect_to admin_colors_path
  end

  private

  def color_params
    params.require(:color).permit(:name, :code)
  end

end
