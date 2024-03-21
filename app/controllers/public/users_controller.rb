class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @items = @user.items.order('id DESC').limit(4)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(current_user.id)
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(current_user.id)
    if @user.guest_user?
      redirect_to root_path, notice: "ゲストユーザーのためプロフィール編集はできません。"
      # 遷移先はマイページ,マイページ編集のボタン表示も後に記述
    end
  end
end
