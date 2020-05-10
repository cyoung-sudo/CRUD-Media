class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @users = User.all
    if Follow.count > 0
      most_followed_id = Follow.group('followee_id').order('COUNT(*) DESC').select('followee_id').limit(1).first
      @most_followed = User.find(most_followed_id.followee_id)
    else
      @most_followed = User.first
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end