class PostsController < ApplicationController

  before_action :authenticate_user!, :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def index_user_specific
    @posts = Post.user_posts(current_user)
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

  def edit
    @event = current_user.posts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "You cannot edit this"
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @event = current_user.posts.find(params[:id]).destroy
    redirect_to root_path
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "You cannot delete this"
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
