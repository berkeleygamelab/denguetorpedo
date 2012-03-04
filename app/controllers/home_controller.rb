class HomeController < ApplicationController
  def index
    @user = User.new
    @all_neighborhoods = Location.top_neighborhoods
    @is_home = "home_nav"
    
    if params[:neighborhood].nil?
      @houses = House.all_in_neighborhoods(@all_neighborhoods.first)
    else
      @houses = House.all_in_neighborhoods(params[:neighborhood])
    end
  end
  
end

