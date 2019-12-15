class CommentsController < ApplicationController
  #creating a comment
  def create
    #creating a variable for the post that the comment wants to be added to
    @post = Post.find(params[:post_id])
    #creating the comment model
    @comment = @post.comments.new(comment_params)
    #sets the user_id of the comment to the id of the user currently logged in
    @comment.user_id = current_user.id if current_user
    #saves the comment
    @comment.save
    #if the comment is saved, redirect back to the post, or it flashes a message declaring comment wasn't saved
    if @comment.save
      redirect_to post_path(@post)
    else
      redirect_to post_path(@post)
      flash[:alert] = t(".comment_add_fail")
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
