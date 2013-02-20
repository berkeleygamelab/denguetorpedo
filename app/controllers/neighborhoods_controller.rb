class NeighborhoodsController < ApplicationController
  def show
    @neighborhood = Neighborhood.find(params[:id])
    head :not_found and return if @neighborhood.nil?
    
    
    @houses = @neighborhood.houses.limit(9)
    @total_reports_in_neighborhood = @neighborhood.reports.count
    @opened_reports_in_neighborhood = @neighborhood.reports.where("status_cd = 0").count
    @claimed_reports_in_neighborhood = @neighborhood.reports.where("status_cd = 1").count
    @eliminated_reports_in_neighborhood = @neighborhood.reports.where("status_cd = 2").count
    @number_of_houses = @neighborhood.houses.count
    @number_of_participants = @neighborhood.members.count
    
    @highlightNeighborhoodItem = ""
    if (@current_user != nil && (@neighborhood.members.member? @current_user)) 
      @highlightNeighborhoodItem = "nav_highlight"
    end
    
    
    @participants = @neighborhood.members.limit(12)
    @participants_view_active = ''
    @houses_view_active = ''
    if params[:view] == 'participants'
      @participants_view_active = 'active'
    else # view == houses
      @houses_view_active = 'active '
    end
    @random_sponsors = []
    9.times do
      @random_sponsors.push('home_images/sponsor'+(rand(5)+1).to_s+'.png')
    end
  end
end
