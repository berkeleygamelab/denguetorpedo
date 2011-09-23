class HomeController < ApplicationController
  def index
    @reports = Report.all.to_gmaps4rails
  end

end
