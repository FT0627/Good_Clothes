class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  private
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if guest_user?
      redirect_to root_path,notice: "ゲストユーザーのためプロフィール編集はできません。"
      # 遷移先はマイページ,マイページ編集のボタン表示も後に記述
    end 
  end
end
