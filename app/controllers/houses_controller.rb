class HousesController < ApplicationController
  def index
  end

  def show
    @house = House.find_by_id(params[:id])
    @isPrivatePage = (@house != nil && @house.members.exists?(@current_user))
  end
end
