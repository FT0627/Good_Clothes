class Admin::RelationshipsController < ApplicationController
  
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.page(params[:page]).per(10).order(created_at: :desc)
  end
  
  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.page(params[:page]).per(10).order(created_at: :desc)
  end

end
