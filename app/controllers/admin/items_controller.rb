class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @item = Item.find(params[:id])
    @tag = @item.tags
  end
  
  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to admin_user_path(user.id)
  end
end
