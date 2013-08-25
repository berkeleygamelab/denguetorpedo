# encoding: utf-8
class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :alert => "E-mail enviado com as instruções para redefinir sua senha."
  end

  def edit
    @user = User.find_by_password_reset_token(params[:id])

    if @user.nil?
      @user = User.find(params[:id])
      @forgot = 0
    else
      @forgot = 1
    end

    # if params[:id] != @current_user.id
    #   head :not_found and return
    # end
  end

  def update
    

    if params[:user][:current_password]
      if @current_user.authenticate(params[:user][:current_password])
        if params[:user][:password] != params[:user][:password_confirmation]
          flash[:alert] = "Password and password confirmation do not match."
          redirect_to :back
          return
        end
        if @current_user.update_attributes(params[:user])
          flash[:notice] = "A senha foi alterada! "
          redirect_to edit_user_path(@current_user)
        else
          flash[:alert] = "There was an error updating your password."
          redirect_to edit_user_path(@current_user)
        end
      else
        flash[:alert] = "You have entered a wrong password."
        redirect_to :back
      end
    else
      @user = User.find_by_password_reset_token!(params[:id])
      if @user.update_attributes(params[:user])
        flash[:notice] = "A senha foi alterada!"
        redirect_to root_url
      else
        flash[:alert] = "There was an error updating your password."
        redirect_to root_url
      end
    end
    
    
    #if @user.password_reset_sent_at < 2.hours.ago
    #  redirect_to new_password_reset_path, :alert => "Password reset has expired."
    #elsif @user.update_attributes(params[:user])
    #  redirect_to root_url, :notice => "Password has been reset!"
    #else
    #  render :edit
    #end
  
  end
end
