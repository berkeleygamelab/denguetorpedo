class HomeController < ApplicationController
  def index

    if (flash[:user].nil?)
      @user = User.new
    else
      @user = flash[:user]
    end
    
    @all_neighborhoods = Neighborhood.limit(3)
    
    if params[:neighborhood].nil?
      if @all_neighborhoods.first.nil?
        @selected_neighborhood = Neighborhood.new
      else 
        @selected_neighborhood = @all_neighborhoods.first
      end
    else
      @selected_neighborhood = Neighborhood.find(params[:neighborhood])
    end
    
    @houses = @selected_neighborhood.houses.limit(10)
    @total_reports_in_neighborhood = @selected_neighborhood.reports.count
    
  end
  
  
  

end

