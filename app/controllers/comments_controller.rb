class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post, only: [:create, :edit, :update, :destroy, :like]
  before_action :get_comment, only: [:edit, :update, :destroy, :like]

  # Creates a comment with respect to the post
  def create
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  # Edit the comment
  def edit
  end

  # Update the comment
  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  # To remove the comment
  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end

  # To post the like for comment
  def like 
    @comment.upvote_by current_user
    redirect_to :back
  end


  private

  # Strong parameter for comment
  def comment_params
    params.require(:comment).permit(:content)
  end

  # To fet the post
  def get_post
    @post = Post.find(params[:post_id])
  end

  # To fetch the comments for specific post
  def get_comment
    @comment = @post.comments.find(params[:id])
  end
end
