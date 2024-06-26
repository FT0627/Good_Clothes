class Public::ShopsController < ApplicationController
  before_action :authenticate_user!

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user_id = current_user.id
    if @shop.save
      flash[:notice] = "You could register the new shop."
      redirect_to shop_path(@shop)
    else
      flash.now[:alert] = "Please fill in the form appropriately."
      render :new
    end
  end

  def index
    @user = User.find(current_user.id)
    @shops = @user.shops.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @shop = Shop.find(params[:id])
  end

  def edit
    @shop = Shop.find(params[:id])
    if @shop.user == current_user
      render :edit
    else
      flash.now[:alert] = "You can't edit this shop !"
      render :show
    end
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      flash[:notice] = "You have successfully updated the shop information."
      redirect_to shop_path(@shop)
    else
      flash.now[:alert] = "Please fill in the form appropriately."
      render :edit
    end
  end

  def destroy
    shop = Shop.find(params[:id])
    shop.destroy
    flash[:notice] = "You have successfully delete the shop !"
    redirect_to shops_path
  end

  private


  def shop_params
    params.require(:shop).permit(:name, :discription, :address, :prefecture, :shop_image)
  end
end
