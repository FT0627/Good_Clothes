class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page]).per(10).order(created_at: :desc)
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page]).per(10).order(created_at: :desc)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

end
