class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    redirect_to posts_path
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post
    @comment.user = current_user
    if @comment.save
      flash[:notice] ="Comment was successfully created."
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def show
    redirect_to posts_path
  end

  def edit
  end

  def update
    @post = @comment.post
    if @comment.update(comment_params)
      flash[:notice] ="Comment was successfully updated."
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post = @comment.post
    @comment.destroy
    flash[:notice] ="Comment was successfully deleted."
    redirect_to post_path(@post)
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def require_same_user
      if current_user != @comment.user
        flash[:alert] ="You don't have permission to access this page."
        redirect_to root_path
      end
    end
end