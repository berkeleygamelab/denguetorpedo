class HousesController < ApplicationController
  
  def index
  end
  
  def show
    @house = House.find_by_id(params[:id])
    #head :not_found and return if @house.nil?
    #@isPrivatePage = (@current_user != nil and @current_user.house == @house)
    #@comment = EventComment.new
  end
end
