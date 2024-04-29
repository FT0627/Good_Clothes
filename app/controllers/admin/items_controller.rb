class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tags = Tag.all
    @categories = Category.all
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @items = @tag.items
    elsif params[:prefecture].present?
      @items = Item.joins(:shop).where(shop: { prefecture: Shop.prefectures[params[:prefecture].to_s] }).order(created_at: :desc)
    elsif params[:category_id].present?
      @category = Category.find(params[:category_id])
      @items = @category.items.all.order(created_at: :desc)
    else
      @items = Item.all.order(created_at: :desc)
    end
  end

  def show
    @item = Item.find(params[:id])
    @tag = @item.tags
    @post_comment = PostComment.new
    @tags = Tag.all
    @categories = Category.all
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:notice] = 'DELETED'
    redirect_to admin_user_path(item.user.id)
  end
end
