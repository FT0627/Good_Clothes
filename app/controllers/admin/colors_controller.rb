class Admin::ColorsController < ApplicationController
  before_action :authenticate_admin!

  def create
    @color = Color.new(color_params)
    if @color.save
      flash[:notice] = 'You have successfully created the new color.'
      redirect_to admin_colors_path
    else
      @colors = Color.all
      flash.now[:alert] = "You have to enter the all forms!"
      render :index
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
      flash[:notice] = 'You have successfully updated the color information.'
      redirect_to admin_colors_path
    else
      flash.now[:alert] = 'You have to enter the all forms !'
      render :edit
    end
  end

  def destroy
    @color = Color.find(params[:id])
    @color.destroy
    flash[:notice] = 'You have successfully deleted the color.'
    redirect_to admin_colors_path
  end

  private

  def color_params
    params.require(:color).permit(:name, :code)
  end

end
