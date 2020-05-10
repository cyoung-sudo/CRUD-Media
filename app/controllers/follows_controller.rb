class FollowsController < ApplicationController
  def follow
    @user = User.find(params[:id])
    if !current_user.followings.include?(@user)
      current_user.followings << @user
      flash[:notice] ="Successfully followed #{@user.first_name} #{@user.last_name}."
      redirect_to user_path(@user)
    else
      flash[:alert] ="You are already following #{@user.first_name} #{@user.last_name}."
      redirect_to user_path(@user)
    end
  end

  def unfollow
    @user = User.find(params[:id])
    if current_user.followings.include?(@user)
      Follow.where(follower_id: current_user.id, followee_id: @user.id).first.destroy
      flash[:notice] ="Successfully unfollowed #{@user.first_name} #{@user.last_name}."
      redirect_to user_path(@user)
    else
      flash[:alert] ="You aren't following #{@user.first_name} #{@user.last_name}."
      redirect_to user_path(@user)
    end
  end
end