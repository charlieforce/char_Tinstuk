class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.create(comment_param)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def comment_param
    params.require(:comment).permit(:text, :post_id)
  end
end
