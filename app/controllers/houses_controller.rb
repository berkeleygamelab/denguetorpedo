class HousesController < ApplicationController
  
  def index
  end
  
  def show
    @house = House.includes(:members, :posts,
                            :location => :neighborhood).find(params[:id])
    head :not_found and return if @house.nil?

    @house_reports_gmap_json = @house.reports.map {|report| report.location}.to_gmaps4rails
    @post = Post.new

    #if @house.posts.exists?
    #  @post = @house.posts.first
    #  @post_comment = Post.new
    #  @post_comment = @post.id
    #end

    @neighbors = House.joins(:location).where(:locations => {:neighborhood_id => @house.neighborhood.id})
    @highlightHouseItem = ""
    if (@current_user != nil && @current_user.house_id == @house.id)
      @highlightHouseItem = "nav_highlight"
    end 
  end
end
