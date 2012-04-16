class NeighborhoodsController < ApplicationController
  def show
    neighborhood = Neighborhood.find(params[:id])
    head :not_found and return if neighborhood.nil?
  end
end
