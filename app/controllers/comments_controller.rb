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

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end