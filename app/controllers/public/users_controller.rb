class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @items = @user.items.order(created_at: :desc).page(params[:page]).per(6)
    @tags = Tag.all
    @categories = Category.all
    @colors = Color.all
  end

  def edit
    @user = User.find(current_user.id)
    if @user == current_user
      render :edit
    else
      flash.now[:alert] = "このユーザー情報は編集できません。"
      render :show
    end
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の更新に成功しました。"
      redirect_to user_path(@user)
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @user = User.find(current_user.id)
    if @user.destroy
      flash[:notice] = "アカウント削除に成功しました。"
      redirect_to root_path
    else
      flash.now[:alert] = "削除に失敗しました。"
      render :show
    end
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user.id).pluck(:shop_id)
    @favorite_shops = Shop.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(current_user.id)
    if @user.guest_user?
      redirect_to root_path, alert: "ゲストユーザーはマイページの編集はできません。"
    end
  end
end
