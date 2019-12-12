class LikeController < ApplicationController
  def create
    @like = Like.new(secure_params)
    @like.post = Post.find(params[:id])
    if @like.save
      respond_to do |format|
        format.html {redirect_to @like.post}
      end
    end
  end

  def destroy
    @like = Like.destroy(secure_params)
  end

  private
  def secure_params
    params.require(:like).permit(:user)
  end
end