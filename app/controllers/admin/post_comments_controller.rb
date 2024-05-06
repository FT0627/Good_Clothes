class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    PostComment.find(params[:id]).destroy
    flash[:notice] = 'You could delete the comment.'
    redirect_to admin_item_path(params[:item_id])
  end
  
end
