class Admin::ShopsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.find(params[:user_id])
    @shops = @user.shops.all.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def edit
    @shop = Shop.find(params[:id])
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      flash[:notice] = "店情報の更新に成功しました。"
      redirect_to admin_shop_path(@shop)
    else
      flash.now[:alert] = "店情報の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @shop = Shop.find(params[:id])
    if @shop.destroy
      flash[:notice] = "店情報の削除に成功しました。"
      redirect_to admin_shops_path
    else
      flash.now[:alert] = "店情報の削除に失敗しました。"  
      render :edit
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :discription, :address, :prefecture, :shop_image)
  end

end
