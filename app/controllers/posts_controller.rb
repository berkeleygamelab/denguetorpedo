# encoding: UTF-8

class PostsController < ApplicationController
  before_filter :require_login, :except => [:index]
  before_filter :load_wall

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @post.user_id = @current_user.id
  end

  def create

    

    @wall.posts.create params[:post] do |post|
      post.user_id = @current_user.id
    end

    if params[:post][:content].empty?
      flash[:alert] = "Descreve a sua idéia."
    end

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
    redirect_to(:back)
  end


  private

  def load_wall
    resource, id = request.path.split('/')[1,2]
    @wall = resource.singularize.classify.constantize.find(id) 
  end
end
