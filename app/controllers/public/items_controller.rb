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
      flash[:notice] = "投稿に成功しました。"
      @item.save_tags(tag_list)
      redirect_to item_path(@item)
    else
      flash.now[:alert] = "投稿できませんでした。"
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @tag = @item.tags
    @post_comment = PostComment.new
    @tags = Tag.all
    @categories = Category.all
    @colors = Color.all
  end

  def edit
    @item = Item.find(params[:id])
    @colors = Color.all
    @tag_list = @item.tags.pluck(:name).join(',')
    if @item.user == current_user
      render :edit
    else
      @post_comment = PostComment.new
      @categories = Category.all
      @tags = Tag.all
      @tag = @item.tags
      flash.now[:alert] = "この投稿は編集できません。"
      render :show
    end
  end

  def update
    @item = Item.find(params[:id])
    tag_list = params[:item][:name].split(',')
    if @item.update(item_params)
      flash[:notice] = "投稿の編集に成功しました。"
      @item.save_tags(tag_list)
      redirect_to item_path(@item)
    else
      flash.now[:alert] = "編集に失敗しました。"
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      flash[:notice] = "投稿の削除に失敗しました。"
      redirect_to root_path
    else
      flash[:alert] = "削除に失敗しました。"
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:user_id, :shop_id, :category_id, :star, color_ids: [], item_images: [])
  end
end
