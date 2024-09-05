class Public::FavoritesController < ApplicationController
  
  def create
    shop = Shop.find(params[:shop_id])
    favorite = current_user.favorites.new(shop_id: shop.id)
    favorite.save
    redirect_to request.referer
  end
  
  def destroy
    shop = Shop.find(params[:shop_id])
    favorite = current_user.favorites.find_by(shop_id: shop.id)
    favorite.destroy
    redirect_to request.referer
  end
  
end
