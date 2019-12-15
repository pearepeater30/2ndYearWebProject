class PostsController < ApplicationController

  before_action :authenticate_user!, :find_post, only: [:show, :edit, :update, :destroy]

  #method for displaying all posts in descending created order
  def index
    @posts = Post.all.order("created_at DESC")
  end

  #method for displaying all of the user's posts
  def index_user_specific
    @posts = Post.user_posts(current_user).order("created_at DESC")
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
  end

  #method used to prevent editing another user's posts through URL manipulation
  def edit
    #execute an event which attempts to check if the current post's user_id that wants to be modified matches the
    # current user's id
    @event = current_user.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    #catches a record not found error if the post's user_id being edited doesn't match with the currently logged in user's
    # id
    redirect_to root_path, alert: t('.post_edit_illegal')
  end

  #Method to update post
  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('.post_update_success')
    else
      render 'edit'
    end
  end

  #method used to delete a post and also prevent deleting another user's posts through URL manipulation
  def destroy
    #execute an event which attempts to check if the current post's user_id that wants to be modified matches the
    # current user's id
    @event = current_user.posts.find(params[:id]).destroy
    redirect_to root_path
  rescue ActiveRecord::RecordNotFound
    #catches a record not found error if the post's id being edited doesn't match with the currently logged in user's
    # id
    redirect_to root_path, alert: t('.post_delete_illegal')
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
