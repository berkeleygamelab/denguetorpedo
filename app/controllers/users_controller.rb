class UsersController < ApplicationController
  
  def show
    @user = User.find_by_id(params[:id])
    @isPrivatePage = (@current_user != nil && @current_user == @user)
    @preventionIdeas = (@user != nil && @user.events.where(:category => PREVENTION_IDEA).order("created_at DESC")) # PREVENTION_IDEA is defined in config/environment.rg
    @neighborhood = @user.house.location.neighborhood if defined? @user.house.location.neighborhood and not @user.house.location.neighborhood.nil?

    if @user.nil?
      render :text => "User not found." and return
    end
    
    respond_to do |format|
      format.html
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, notice: 'Signed up!'
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
    render "show" if @user != @current_user
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user != @current_user
      render "show"
    elsif @user.update_attributes(params[:user])
      redirect_to user_url(@user), notice: 'Successfully update profile'
    else
      render "edit"
    end  
  end

end
