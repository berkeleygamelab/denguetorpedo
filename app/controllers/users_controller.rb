class UsersController < ApplicationController

  before_filter :require_login, :only => [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find_by_id(params[:id])
    head :not_found and return if @user.nil?
    
    @isPrivatePage = (@current_user != nil && @current_user == @user)
    @highlightProfileItem = ""
    if @isPrivatePage
      @highlightProfileItem = "nav_highlight"
    end
    @neighborhood = @user.neighborhood
    
    @house = @user.house
    @reports = @user.reports
    
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
      redirect_to edit_user_path(@user.id)
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
    @user = @current_user

    user_attributes = params[:user]
    house_attributes = user_attributes[:house_attributes]
    location_attributes = user_attributes[:location]

    # delete the nested attributes
    user_attributes.delete :house_attributes
    house_attributes.delete :location
    
    @user.profile_photo = params[:user][:profile_photo]
    successful = @user.update_attributes(user_attributes)

    if successful
      # if the house name is blank, remove this uers's house
      if house_attributes[:name].blank?
        if @user.house_id != nil
          @user.house_id = nil
          @user.save
        end

      # user doesn't have a house or the house name is different
      elsif @user.house.nil? || (@user.house && @user.house.name != house_attributes[:name])

        # if the house doesn't already exists, create one with the location given
        house = House.find_by_name(house_attributes[:name])
        if house.nil?
          house = House.new(:name => house_attributes[:name])
          house.location = Location.find_or_create(location_attributes[:address])
          successful &&= house.save
        end
        @user.house = house
        successful &&= @user.save
      end
    end

    if successful
      redirect_to user_url(@user), notice: 'Successfully update profile'
    else
      render "edit"
    end  
  end

end
