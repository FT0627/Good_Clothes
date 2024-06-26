class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @items = @user.items.order(created_at: :desc).page(params[:page]).per(6)
    @tags = Tag.all
    @categories = Category.all
    @colors = Color.all
  end

  def edit
    @user = User.find(current_user.id)
    if @user == current_user
      render :edit
    else
      flash.now[:alert] = "You can't edit the profile !!"
      render :show
    end
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
    flash[:notice] = "You have successfully updated the profile."
      redirect_to user_path(@user)
    else
    flash.now[:alert] = "Please fill in the form appropriately."
      render :edit
    end
  end

  def destroy
    @user = User.find(current_user.id)
    @user.destroy
    flash[:notice] = "You have successfully deleted the account."
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :profile_image)
  end

  def ensure_guest_user
    @user = User.find(current_user.id)
    if @user.guest_user?
      redirect_to root_path, alert: "Guesst user can't the profile!!"
    end
  end
end
