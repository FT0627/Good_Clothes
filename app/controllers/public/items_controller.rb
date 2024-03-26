class Public::ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def new
    @item = Item.new
    @colors = Color.all
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    tag_list = params[:item][:name].split(',')
    if @item.save
      @item.save_tags(tag_list)
      redirect_to item_path(@item)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @tag = @item.tags
    @post_comment = PostComment.new
  end

  def edit
    @item = Item.find(params[:id])
    @colors = Color.all
    @tag_list = @item.tags.pluck(:name).join(',')
    if @item.user == current_user
      render :edit
    else
      render :show
    end
  end

  def update
    @item = Item.find(params[:id])
    tag_list = params[:item][:name].split(',')
    if @item.update(item_params)
      @item.save_tags(tag_list)
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
    params.require(:item).permit(:user_id, :shop_id, :category_id, :star, color_ids: [], item_images: [])
  end
end
