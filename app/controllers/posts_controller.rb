class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
    # @most_liked = Post.first
    most_liked_id = Like.group('post_id').order('COUNT(*) DESC').select('post_id').limit(1).first
    puts "__________________#{most_liked_id.post_id}__________________"
    @most_liked = Post.find(most_liked_id.post_id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] ="Post was successfully created."
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] ="Post was successfully updated."
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] ="Post was successfully deleted."
    redirect_to posts_path
  end

  def feed
    @posts = Post.all
  end

  private
    def post_params
      params.require(:post).permit(:title, :description)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    def require_same_user
      if current_user != @post.user
        flash[:alert] ="You don't have permission to access this page."
        redirect_to root_path
      end
    end
end