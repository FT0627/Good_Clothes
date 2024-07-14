class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    item = Item.find(params[:item_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.item_id = item.id
    
    if comment.save
      flash[:notice] = "コメントに成功しました。"
      redirect_to item_path(item)
    else 
      flash[:alert] = "コメントに失敗しました。"
      redirect_to item_path(item)
    end
  end

  def destroy
    comment = PostComment.find(params[:id])
    user_id = comment.user_id
    item = Item.find(comment.item_id)
    post_user_id = item.user_id
    
    if user_id == current_user.id || post_user_id = current_user.id
      comment.destroy
      flash[:notice] = "削除に成功しました。"
      redirect_to item_path(item)
    else
      flash[:alert] = "削除に失敗しました。"
      redirect_to item_path(item)
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
