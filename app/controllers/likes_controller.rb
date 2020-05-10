class LikesController < ApplicationController
  def like
    @post = Post.find(params[:id])
    if !current_user.liked.include?(@post)
      current_user.liked << @post
      flash[:notice] ="Successfully liked post."
      redirect_to post_path(@post)
    else
      flash[:alert] ="You already liked post."
      redirect_to post_path(@post)
    end
  end

  def unlike
    @post = Post.find(params[:id])
    if current_user.liked.include?(@post)
      Like.where(user_id: current_user.id, post_id: @post.id).first.destroy
      flash[:notice] ="Successfully unliked post."
      redirect_to post_path(@post)
    else
      flash[:alert] ="You haven't liked the post."
      redirect_to post_path(@post)
    end
  end
end