class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :get_post, only: [:create, :edit, :update, :destroy, :like]
	before_action :get_comment, only: [:edit, :update, :destroy, :like]

	def create
		# creates a comment with respect to the post
		@comment = @post.comments.create(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @comment.update(comment_params)
			redirect_to post_path(@post)
		else
			render 'edit'
		end
	end

	def destroy
		@comment.destroy
		redirect_to post_path(@post)
	end

    def like 
	  @comment.upvote_by current_user
	  redirect_to :back
	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end

	def get_post
		@post = Post.find(params[:post_id])
	end

	def get_comment
		@comment = @post.comments.find(params[:id])
    end
end
