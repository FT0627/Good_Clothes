class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    item = Item.find(params[:item_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.item_id = item.id
    
    if comment.save
      flash[:notice] = "You have successfully posted your comment."
      redirect_to item_path(item)
    else 
      flash[:alert] = "You failed to post your comment."
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
      flash[:notice] = "You have successfully deleted your comment."
      redirect_to item_path(item)
    else
      flash[:alert] = "You failed to delete the comment."
      redirect_to item_path(item)
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
