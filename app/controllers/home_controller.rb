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
    
    @all_neighborhoods = Location.top_neighborhoods
    @is_home = "home_nav"
    
    if params[:neighborhood].nil?
      @houses = House.all_in_neighborhoods(@all_neighborhoods.first)
      @selected_neighborhood = @all_neighborhoods.first
    else
      @houses = House.all_in_neighborhoods(params[:neighborhood])
      @selected_neighborhood = params[:neighborhood]
    end
    @total_reports_in_neighborhood = Report.joins(:location).where(:locations => {:neighborhood => @selected_neighborhood}).count
    
    #Report.count_by_sql("SELECT COUNT(*) FROM reports, users, houses, locations WHERE (reports.reporter_id = users.id OR reports.claimer_id = users.id OR reports.eliminator_id = users.id) AND users.house_id = houses.id AND houses.location_id = locations.id AND locations.neighborhood = 'South Side'")
  end
  
end

