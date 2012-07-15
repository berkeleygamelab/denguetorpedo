class UsersController < ApplicationController

  before_filter :require_login, :only => [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def show
    @post = Post.create

    @user = User.find_by_id(params[:id])
    head :not_found and return if @user.nil?

    @user_posts = @user.posts
    @house = @user.house
    @neighborhood = @user.neighborhood
    
    @isPrivatePage = (@user == @current_user)
    @highlightProfileItem = @isPrivatePage ? "nav_highlight" : ""
    
    if params[:filter] == 'reports'
      @feed_active_reports = 'active'
    elsif params[:filter] == 'posts'
      @feed_active_posts = 'active'
    else
      @feed_active_all = 'active'
    end

    @stats_hash = {}
    @stats_hash['opened'] = @user.created_reports.count
    @stats_hash['claimed'] = @user.claimed_reports.count
    @stats_hash['eliminated'] = @user.eliminated_reports.count
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to edit_user_path(@user)
    else
      flash[:user] = @user
      render new_user_path(@user)
    end
  end

  def edit
    @user = @current_user
    @user.house ||= House.new
    @user.house.location ||= Location.new
    @highlightAccountItem = "nav_highlight"
  end
  
  def update
    house_name = params[:user][:house_attributes][:name]
    address = params[:user][:location][:address]
    profile_photo = params[:user][:house_attributes][:profile_photo]

    @current_user.username = params[:user][:username]

    # only save profile photo if user uploads one
    if params[:user][:profile_photo]
      @current_user.profile_photo = params[:user][:profile_photo] 
    end
    
    # change the email only if the user provided one
    if not params[:user][:email].blank?
      @current_user.email = params[:user][:email]
    end

    @current_user.save

    @current_user.house = House.find_or_create(house_name, address, profile_photo)
 
    @user = @current_user
    if @current_user.save
      redirect_to user_url(@current_user), notice: 'Successfully update profile'
    else
      @user.house = House.new(name: house_name)
      @user.house.location = Location.new
      render "edit"
    end  
  end
end
