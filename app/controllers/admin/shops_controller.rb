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
    @shop.update(shop_params)
    flash[:notice] = "You have successfully updated the shop information."
    redirect_to admin_shop_path(@shop)
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    flash[:notice] = "You have successfully deleted the shop."
    redirect_to admin_shops_path
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :discription, :address, :prefecture, :shop_image)
  end

end
