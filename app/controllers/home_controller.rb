class HomeController < ApplicationController
  def index
    @collapse = 'collapse'

    if (flash[:user].nil?)
      @user = User.new
    else
      @user = flash[:user]
    end
    
    @all_neighborhoods = Neighborhood.order(:id).limit(3)
    
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
    @opened_reports_in_neighborhood = @selected_neighborhood.reports.where("status_cd = 0").count
    @claimed_reports_in_neighborhood = @selected_neighborhood.reports.where("status_cd = 1").count
    @eliminated_reports_in_neighborhood = @selected_neighborhood.reports.where("status_cd = 2").count

  end
end

