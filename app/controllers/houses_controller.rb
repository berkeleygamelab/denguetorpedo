class HousesController < ApplicationController
  def index
  end

  def show
    @house = House.find_by_id(params[:id])
    @isPrivatePage = (@current_user != nil and @current_user.house == @house)

    respond_to do |format|
      format.html
    end
  end
end
