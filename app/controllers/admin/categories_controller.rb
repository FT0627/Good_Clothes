class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
    flash[:notice] = 'You have successfully posted the new category.'
      redirect_to admin_categories_path
    else
      flash[:alert]= "You have to enter the form !"
      @categories = Category.all
      render :index
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = 'You have successfully updated the shop information.'
      redirect_to admin_categories_path
    else
      flash[:notice] = 'You have to enter the form !'
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = 'You have successfully deleted the category.'
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
