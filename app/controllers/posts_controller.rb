class PostsController < ApplicationController
  def index
    @posts = Post.includes(:comments).where(interest_id: current_user.interests.select(&:id))
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def destroy
    current_user.posts.find(params[:id]).destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def post_params
    params.require(:post).permit(:text, :attachment, :interest_id)
  end
end
