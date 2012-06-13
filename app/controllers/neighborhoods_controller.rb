class NeighborhoodsController < ApplicationController
  def show
    @neighborhood = Neighborhood.find(params[:id])
    head :not_found and return if @neighborhood.nil?
    
    
    @houses = @neighborhood.houses.limit(10)
    @total_reports_in_neighborhood = @neighborhood.reports.count
  end
end
