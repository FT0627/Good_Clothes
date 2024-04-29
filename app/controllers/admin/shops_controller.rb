class Admin::ShopsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @shops = Shop.all.page(params[:page]).per(10).order(created_at: :desc)
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
    redirect_to admin_shop_path(@shop)
  end

  def destroy
    @shop = Shop.find(params[:id])
    @shop.destroy
    redirect_to admin_shop_path(@shop)
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :discription, :address, :prefecture, :shop_image)
  end

end
