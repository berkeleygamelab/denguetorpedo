class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = @current_user

    # if params[:id] != @current_user.id
    #   head :not_found and return
    # end
  end

  def update
    @user = @current_user
    if @user.authenticate(params[:user][:current_password])
      if params[:user][:password] != params[:user][:password_confirmation]
        flash[:alert] = "Password and password confirmation do not match."
        redirect_to :back
        return
      end
      if @user.update_attributes(params[:user])
        flash[:notice] = "Password has been reset!"
        redirect_to edit_user_path(@user)
      else
        flash[:alert] = "There was an error updating your password."
        redirect_to edit_user_path(@user)
      end
    else
      flash[:alert] = "You have entered a wrong password."
      redirect_to :back
    end
    
    #@user = User.find_by_password_reset_token!(params[:id])
    #if @user.password_reset_sent_at < 2.hours.ago
    #  redirect_to new_password_reset_path, :alert => "Password reset has expired."
    #elsif @user.update_attributes(params[:user])
    #  redirect_to root_url, :notice => "Password has been reset!"
    #else
    #  render :edit
    #end
  
  end
end
