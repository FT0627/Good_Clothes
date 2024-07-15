class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'カテゴリーの登録に成功しました。'
      redirect_to admin_categories_path
    else
      @categories = Category.all
      flash.now[:alert]= "カテゴリーの登録に失敗しました。"
      render :index
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = 'カテゴリー情報の更新に成功しました。'
      redirect_to admin_categories_path
    else
      flash.now[:notice] = 'カテゴリー情報の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      flash[:notice] = 'カテゴリー情報の削除に成功しました。'
      redirect_to admin_categories_path
    else
      flash.now[:alert] = 'カテゴリー情報の削除に失敗しました。'
      render :index
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
