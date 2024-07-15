class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @items = @user.items.order(created_at: :desc).page(params[:page]).per(6)
    @tags = Tag.all
    @categories = Category.all
    @colors = Color.all
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "ユーザー情報の削除に成功しました。"
      redirect_to admin_root_path
    else
      flash.now[:alert] = "ユーザー情報の削除に失敗しました。"
      redirect_to admin_user_path(@user)
    end
  end

end
