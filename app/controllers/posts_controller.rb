class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_post, only: [:show, :edit, :update, :destroy, :like]
  before_action :remove_params, only: :index

  # To show all the posts	and with search criteria
  def index
    if params[:search] && params[:user_id]
      @posts = Post.search_all(params)
    elsif params[:search]
      @posts = Post.search_post(params)
    elsif params[:user_id]
      @posts = Post.search_user(params)
    else
      @posts = Post.all
    end	  
    @posts = @posts.order("created_at DESC").page(params[:page])
  end

  # To get particular post
  def show
  end

  # For new post build
  def new
    @post = current_user.posts.build
  end

  # To create a new post
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  # To edit a post
  def edit
    if !@post.editable?
      redirect_to @post, flash: { alert: "Sorry! You can not edit your post." }
    end
  end

  # To update a particular post
  def update
    if @post.update(post_params)
      redirect_to post_path
    else
      render 'edit'
    end
  end

  # To remove a post
  def destroy
    @post.destroy
    redirect_to posts_path
  end

  # To post a like for specific post
  def like 
    @post.upvote_by current_user
    redirect_to :back
  end

  private
  # Strong params for create a post
  def post_params
    params.require(:post).permit(:title, :description, :website_url)
  end

  # To get a particular post
  def get_post
    @post = Post.find(params[:id])
  end

  # To remove the empty params 
  def remove_params
    params.reject!{|_, v| v.blank?}
  end
end
