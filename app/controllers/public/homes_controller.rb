class Public::HomesController < ApplicationController

  def top
    @tags = Tag.all
    if params[:tag_id].present?
      @tag_id = params[:tag_id]
      @tag = Tag.find(@tag_id)
      @items = @tag.items
    elsif params[:prefecture].present?
      @items = Shop.joins(:items).where(prefecture: Shop.prefectures[params[:prefecture].to_sym]).first.items
    else
      @items = Item.all
    end
  end

end
