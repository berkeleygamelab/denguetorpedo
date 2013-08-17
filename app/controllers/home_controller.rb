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
    ##3hihi
    @participants = @selected_neighborhood.members.where('role != ?', "lojista")

    @houses = @participants.map { |participant| participant.house }.uniq
    
    @prizes = Prize.where('stock > 0')
    @notices = @selected_neighborhood.notices[0..3]
    @total_reports_in_neighborhood = @selected_neighborhood.total_reports.count
    @opened_reports_in_neighborhood = @selected_neighborhood.open_reports.count
    @eliminated_reports_in_neighborhood = @selected_neighborhood.eliminated_reports.count
  end

end

