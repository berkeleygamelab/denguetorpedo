class UsersController < ApplicationController
  # GET /users
  def show
    @user = @current_user

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
        session[:user_id] = @user.id
        format.html { redirect_to root_url, notice: 'Signed up!' }
      else
        format.html { render "new" }
      end
    end
  end

end
