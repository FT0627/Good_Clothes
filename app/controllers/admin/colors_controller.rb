class Admin::ColorsController < ApplicationController
  before_action :authenticate_admin!

  def create
    @color = Color.new(color_params)
    if @color.save
      flash[:notice] = 'カラーの登録に成功しました。'
      redirect_to admin_colors_path
    else
      @colors = Color.all
      flash.now[:alert] = "カラーの登録に失敗しました。"
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
      flash[:notice] = 'カラー情報の更新に成功しました。'
      redirect_to admin_colors_path
    else
      flash.now[:alert] = 'カラー情報の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @color = Color.find(params[:id])
    if @color.destroy
      flash[:notice] = 'カラー情報の削除に成功しました。'
      redirect_to admin_colors_path
    else
      flash.now[:alert] = 'カラー情報の削除に失敗しました。'
      render :index
    end
  end

  private

  def color_params
    params.require(:color).permit(:name, :code)
  end

end
