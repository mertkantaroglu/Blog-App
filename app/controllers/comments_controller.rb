class CommentsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @posts = Post.find(params[:id])
    @comments = Comment.find(params[:comment_id])

    respond_to do |format|
      format.htmlformat.json { render json: @comments }
    end
  end


  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      respond_to do |format|
      format.html {redirect_to "/users/#{current_user.id}/posts/#{params[:post_id]}", notice: 'Comment created successfully'}
      format.json { render json: @comment, status: :created}
      end

    else
      respond_to do |format|
        format.html {render :new}
        format.json { render json: @comment.errors, status: :unprocessable_entry}
      end
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
