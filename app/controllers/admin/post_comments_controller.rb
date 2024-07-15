class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    if PostComment.find(params[:id]).destroy
      flash[:notice] = 'コメントの削除に成功しました。'
      redirect_to admin_item_path(params[:item_id])
    else 
      flash[:alert] = 'コメントの削除に失敗しました。'
      redirect_to admin_item_path(params[:item_id])
    end
  end

end
