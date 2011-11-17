class HomeController < ApplicationController
  def index
    reports = Report.includes(:location).where("location_id IS NOT NULL")
    @locations = reports.map do |r| r.location end
    @locations = @locations.to_gmaps4rails
  end
end
