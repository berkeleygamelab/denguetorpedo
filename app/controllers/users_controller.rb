class UsersController < ApplicationController

  before_filter :require_login, :only => [:edit, :update]
  
  def show
    @user = User.find_by_id(params[:id])
    @isPrivatePage = (@current_user != nil && @current_user == @user)
    @preventionIdeas = (@user != nil && @user.events.where(:category => PREVENTION_IDEA).order("created_at DESC")) # PREVENTION_IDEA is defined in config/environment.rg
    @neighborhood = @user.neighborhood

    if @user.nil?
      render :text => "User not found." and return
    end
    
    respond_to do |format|
      format.html
    end
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to edit_user_path(@user.id)
    else
      flash[:user] = @user
      redirect_to root_url
    end
  end

  def edit
    @user = @current_user
    @user.house ||= House.new
    @user.house.location ||= Location.new
  end
  
  def update
    @user = @current_user

    user_attributes = params[:user]
    house_attributes = user_attributes[:house_attributes]
    location_attributes = house_attributes[:location_attributes]

    # delete the nested attributes
    user_attributes.delete :house_attributes
    house_attributes.delete :location_attributes

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
