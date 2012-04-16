class HomeController < ApplicationController
  def index

    if (flash[:user].nil?)
      @user = User.new
    else
      @user = flash[:user]
    end
    
    #if (params[:user].nil?)
      
    #else
    #  @user = User.new(:username => params[:user][:username], :email => params[:user][:email])
    #end
    
    @all_neighborhoods = Neighborhood.all
    @is_home = "home_nav"
    
    if params[:neighborhood].nil?
      @selected_neighborhood = @all_neighborhoods.first
    else
      @selected_neighborhood = Neighborhood.find(params[:neighborhood])
    end
    @houses = @selected_neighborhood.houses

    @total_reports_in_neighborhood = @selected_neighborhood.reports.count
  end

end

