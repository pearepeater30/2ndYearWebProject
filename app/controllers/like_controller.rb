class LikeController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    #creating a variable for the post that the like wants to be added to
    @post = Post.find(params[:post_id])
    #creating the like model
    @like = @post.likes.new
    #sets the user_id of the like to the id of the user currently logged in
    @like.user_id = current_user.id if current_user
    #saves the like
    @like.save
    #if the like is saved, redirect back to the post, or it flashes a message declaring like wasn't saved
    if @like.save
      redirect_to post_path(@post)
    else
      redirect_to posts_path(@post), alert: t('.like_add_fail')
    end
  end

  def destroy
    #destroys the posts like that belongs to the currently logged in user
    @post.likes.where(user_id: current_user.id).destroy_all
    redirect_to post_path(@post)
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end