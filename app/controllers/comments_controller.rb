class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to "/users/#{current_user.id}/posts/#{params[:post_id]}", notice: 'Comment created successfully'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to user_posts_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
