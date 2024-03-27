class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tags = Tag.all
    if params[:tag_id].present?
      @tag_id = params[:tag_id]
      @tag = Tag.find(@tag_id)
      @items = @tag.items
    else
     @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @tag = @item.tags
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to admin_user_path(item.user.id)
  end
end
