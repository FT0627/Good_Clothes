class Public::ShopsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user_id = current_user.id
    if @shop.save
      redirect_to shop_path(@shop)
    else
      render :new
    end
  end

  def index
    @shops = Shop.all
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def edit
    @shop = Shop.find(params[:id])
    if @shop.user == current_user
      render :edit
    else
      render :show
    end
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      redirect_to shop_path(@shop)
    else
      render :show
    end
  end

  def destroy
    shop = Shop.find(params[:id])
    shop.destroy
    redirect_to shops_path
  end

  private


  def shop_params
    params.require(:shop).permit(:name, :discription, :address, :prefecture, :shop_image)
  end
end
