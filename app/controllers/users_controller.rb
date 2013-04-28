#!/bin/env ruby
# encoding: utf-8

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
    
    user_profile_phone_number = params[:user][:phone_number]
    user_profile_phone_number_confirmation = params[:phone_number_confirmation]
    user_profile_photo = params[:user][:profile_photo]
    user_email = params[:user][:email]
  
    if user_profile_phone_number != @current_user.phone_number
      if user_profile_phone_number == user_profile_phone_number_confirmation
        @current_user.phone_number = user_profile_phone_number
      else
        @user = @current_user
        @confirm = 0
        flash[:notice] = "phone number confirmation does not match with the provided phone number"
        render "edit"
        return
      end
    end
    
    if user_profile_photo
      @current_user.profile_photo = user_profile_photo
    end
    
    if not user_email.blank?
      @current_user.email = user_email
    end

    # if a house exists with the same house name or house address, inform the user for confirmation
    if params[:user][:confirm] == "0" && !house_name.blank? && House.find_by_name(house_name) && (house_name != @current_user.house.name)
      @user = @current_user
      @user.house.name = house_name
      @confirm = 1
      flash[:notice] = "Uma casa com esse nome já existe. Você quer se juntar a essa casa? Se sim, clique confirmar. Se não, clique cancelar e escolha outro nome de casa."
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
