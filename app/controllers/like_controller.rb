class LikeController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new
    @like.user_id = current_user.id if current_user
    @like.save
    if @like.save
      redirect_to post_path(@post)
    else
      redirect_to posts_path(@post), alert: t('.like_add_fail')
    end
  end

  def destroy
    @post.likes.where(user_id: current_user.id).destroy_all
    redirect_to post_path(@post)
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end