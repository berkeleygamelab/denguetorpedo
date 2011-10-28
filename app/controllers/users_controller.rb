class UsersController < ApplicationController
  # GET /users
  def show
    @user = User.find_by_id(params[:id])
    @isPrivatePage = (@current_user != nil && @current_user == @user)
    @preventionIdeas = (@user != nil && @user.events.where(:category => PREVENTION_IDEA).order("created_at DESC")) # PREVENTION_IDEA is defined in config/environment.rg
    
    respond_to do |format|
      format.html
    end
  end

  # GET /users/new
  def new
    @user = User.new

    respond_to do |format|
      format.html
    end
  end

  # POST /users
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        cookies[:auth_token] = @user.auth_token
        format.html { redirect_to root_url, notice: 'Signed up!' }
      else
        format.html { render "new" }
      end
    end
  end

end
