class Public::ShopsController < ApplicationController
  before_action :authenticate_user!

  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    @shop.user_id = current_user.id
    if @shop.save
      flash[:notice] = "店舗情報の登録に成功しました。"
      redirect_to shop_path(@shop)
    else
      flash.now[:alert] = "登録に失敗しました。"
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
      flash.now[:alert] = "この店舗情報は編集できません。"
      render :show
    end
  end

  def update
    @shop = Shop.find(params[:id])
    if @shop.update(shop_params)
      flash[:notice] = "店舗情報の更新に成功しました。"
      redirect_to shop_path(@shop)
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    shop = Shop.find(params[:id])
    if shop.destroy
      flash[:notice] = "店舗情報の削除に成功しました。"
      redirect_to shops_path
    else
      flash[:alert] = "削除に失敗しました。"
    end
  end

  private


  def shop_params
    params.require(:shop).permit(:name, :discription, :address, :prefecture, :shop_image)
  end
end
