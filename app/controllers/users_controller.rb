class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:format])
    @posts = @user.posts
  end
end