class NeighborhoodsController < ApplicationController
  def show
    @neighborhood = Neighborhood.find(params[:id])
    head :not_found and return if @neighborhood.nil?
    
    
    @houses = @neighborhood.houses.limit(10)
    @total_reports_in_neighborhood = @neighborhood.reports.count
    
    @highlightNeighborhoodItem = ""
    if (@current_user != nil && (@neighborhood.members.member? @current_user)) 
      @highlightNeighborhoodItem = "nav_highlight"
    end
    
    
    @participants = @neighborhood.members.limit(13)
    @participants_view_active = ''
    @houses_view_active = ''
    if params[:view] == 'participants'
      @participants_view_active = 'active'
    else # view == houses
      @houses_view_active = 'active '
    end
    
  end
end
