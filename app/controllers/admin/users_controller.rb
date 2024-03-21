class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @user = User.find(params[:id])
    @items = @user.items.order('id DESC').limit(4)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_root_path
  end
end
