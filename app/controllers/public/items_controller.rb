class Public::ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def new
    @item = Item.new
    @colors = Color.all
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @colors = Color.all
    if @item.user == current_user
      render :edit
    else
      render :show
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:user_id, :shop_id, :category_id, color_ids: [], item_images: [])
  end
end
