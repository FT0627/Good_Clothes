class Public::HomesController < ApplicationController

  def top
    @tags = Tag.all
    @categories = Category.all
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @items = @tag.items
    elsif params[:prefecture].present?
      @items = Item.joins(:shop).where(shop: { prefecture: Shop.prefectures[params[:prefecture].to_s] })
    elsif params[:category_id].present?
      @category = Category.find(params[:category_id])
      @items = @category.items.all
    else
      @items = Item.all
    end
  end

end
