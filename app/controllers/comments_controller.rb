class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment].permit(:comment))
    @comment.user_id = current_user.id if current_user
    @comment.save
    if @comment.save
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post)
      flash[:alert] = "You must add a comment"
    end
  end
end
