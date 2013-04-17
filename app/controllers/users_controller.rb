class UsersController < ApplicationController

  before_filter :require_login, :only => [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def show
    @post = Post.new

    @user = User.find_by_id(params[:id])
    head :not_found and return if @user.nil?

    @user_posts = @user.posts
    

    @house = @user.house
    @neighborhood = @user.neighborhood
    @prizes = @user.prizes
    @prize_ids = @prizes.collect{|prize| prize.id}
    @badges = @user.badges
    
    @isPrivatePage = (@user == @current_user)
    @highlightProfileItem = @isPrivatePage ? "nav_highlight" : ""
    
    if params[:filter] == 'reports'
      @feed_active_reports = 'active'
      @combined_sorted = @user.reports
    elsif params[:filter] == 'posts'
      @combined_sorted = @user.posts
      @feed_active_posts = 'active'
    else
      @feed_active_all = 'active'
      @combined_sorted = (@user.reports + @user.posts).sort{|a,b| b.created_at <=> a.created_at }
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
      render new_user_path(@user)
    end
  end

  def edit
    @user = @current_user
    @user.house ||= House.new
    @user.house.location ||= Location.new
    @highlightAccountItem = "nav_highlight"
    @confirm = 0
    flash[:notice] = nil
  end
  
  def update
    puts params
    house_name = params[:user][:house_attributes][:name]
    house_address = params[:user][:location][:address]
    house_neighborhood = params[:user][:location][:neighborhood]
    house_profile_photo = params[:user][:house_attributes][:profile_photo]
    
    user_profile_photo = params[:user][:profile_photo]
    user_email = params[:user][:email]
  
    if user_profile_photo
      @current_user.profile_photo = user_profile_photo
    end
    
    if not user_email.blank?
      @current_user.email = user_email
    end
    
    puts params[:user][:confirm]
    
    # if a house exists with the same house name or house address, inform the user for confirmation
    if params[:user][:confirm] == "0" && !house_name.blank? && House.find_by_name(house_name)
      @user = @current_user
      @user.house.name = house_name
      @confirm = 1
      flash[:notice] = "A house with this house already exist. Are you sure you want to join?"
      render "edit"
    else
      @current_user.house = House.find_or_create(house_name, house_address, house_neighborhood, house_profile_photo)
      @user = @current_user
    
      if @current_user.save
        redirect_to edit_user_path(@current_user), notice: 'Successfully update profile'
      else
        @user.house = House.new(name: house_name)
        @user.house.location = Location.new
        render "edit"
      end 
    end 
  end
  

  #Get /user/:id/buy_prize/prize_id
  def buy_prize
    @user = User.find(params[:id])
    bought = @user.buy_prize(params[:prize_id])
    if bought
      @prize_code = PrizeCode.where(:prize_id => params[:prize_id], :user_id => params[:id]).limit(1)[0]
    end
    render :partial => "prizes/prizeconfirmation", :locals => {:bought => bought}
  end
end
