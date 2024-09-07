class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shop
  
  def create
    shop = Shop.find(params[:shop_id])
    favorite = current_user.favorites.new(shop_id: shop.id)
    favorite.save
  end
  
  def destroy
    shop = Shop.find(params[:shop_id])
    favorite = current_user.favorites.find_by(shop_id: shop.id)
    favorite.destroy
  end
  
  
  private
  
  def set_shop
    @shop = Shop.find(params[:shop_id])
  end
end
