class TagsController < ApplicationController
  def index
    redirect_to posts_path
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)
    @post = Post.find(params[:post_id])
    @tag.post = @post
    if !@post.tags.include?(@tag) and @tag.save
      flash[:notice] ="Tag was successfully created."
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @post = @tag.post
    @tag.destroy
    flash[:notice] ="Tag was successfully deleted."
    redirect_to post_path(@post)
  end

  private
    def tag_params
      params.require(:tag).permit(:content)
    end
end