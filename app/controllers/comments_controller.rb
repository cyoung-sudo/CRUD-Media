class CommentsController < ApplicationController
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
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:notice] ="Comment was successfully updated."
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] ="Comment was successfully deleted."
    redirect_to posts_path
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end