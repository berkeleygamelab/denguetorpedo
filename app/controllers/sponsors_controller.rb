class SponsorsController < ApplicationController
	def show
		sponsor_id = params[:id]
		@sponsor = User.find_by_id(sponsor_id)
		@prizes = @sponsor.prizes

		@sponsor.house.location.latitude ||= 0
		@sponsor.house.location.longitude ||= 0
		@latitude = @sponsor.house.location.latitude
		@longitude = @sponsor.house.location.longitude
		
		respond_to do |format|
			if @sponsor.role != "lojista"
				raise ActionController::RoutingError.new('Not Found')
			else
				format.html
			end
		end
	end

	def new
		@user = User.new
	end
end
