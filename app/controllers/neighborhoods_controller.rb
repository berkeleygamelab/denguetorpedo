class NeighborhoodsController < ApplicationController
  
  def show
    @neighborhood = Neighborhood.find(params[:id])
    head :not_found and return if @neighborhood.nil?
    
    @participants = @neighborhood.members.where('role != ?', "lojista")
    @participants_view_active = ''

    @houses = @participants.map { |participant| participant.house }.uniq
    @total_reports_in_neighborhood = @neighborhood.total_reports.count
    @opened_reports_in_neighborhood = @neighborhood.open_reports.count
    @eliminated_reports_in_neighborhood = @neighborhood.eliminated_reports.count
    @number_of_houses = @houses.count
    @number_of_participants = @participants.count
    
    @notices = @neighborhood.notices
    @highlightNeighborhoodItem = ""
    
    if (@current_user != nil && (@neighborhood.members.member? @current_user)) 
      @highlightNeighborhoodItem = "nav_highlight"
    end
    
    
    @houses_view_active = ''
    
    if params[:view] == 'participants'
      @participants_view_active = 'active'
    else # view == houses
      @houses_view_active = 'active '
    end
    
    @coordinators = @participants.where(:role => "coordenador")
    @verifiers = @participants.where(:role => "verificador")
    @coordinator_blogs = @participants.where(:role => "coordenador").map { |coor| coor.posts.last }.select{ |x| !x.nil?}.sort { |x, y| y.created_at <=> x.created_at}
    @verifier_blogs = @participants.where(:role => "verificador").map { |veri| veri.posts.last }.select{ |x| !x.nil?}.sort { |x, y| y.created_at <=> x.created_at }
    # @notices = Notice.where(:)

    @sponsors = @neighborhood.members.where(:role => "lojista")
    @random_sponsors = []
    9.times do
      @random_sponsors.push('home_images/sponsor'+(rand(5)+1).to_s+'.png')
    end
  
  end
end
