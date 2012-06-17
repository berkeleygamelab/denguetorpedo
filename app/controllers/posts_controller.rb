class PostsController < ApplicationController
  before_filter :require_login, :except => [:index]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @post.user_id = @current_user.id
  end

  def create
    params[:post][:user_id] = @current_user.id
    Post.create params[:post]
    redirect_to :back
  end

  def show
    @post = Post.find params[:id]
    head :not_found and return if @post.nil?
  end

  def edit
    @post = Post.find params[:id]
    head :forbidden and return if @post.user_id != @current_user.id
  end

  def update
    post = Post.find params[:post][:id]
    head :not_found and return if post.nil?
    head :forbidden and return if post.user_id != @current_user.id
    post.update_attributes params[:post]
  end

  def destroy
    post = Post.find params[:id]
    head :forbidden and return if post.user_id != @current_user.id
    post.destroy
  end
end
