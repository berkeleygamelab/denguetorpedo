class SponsorsController < ApplicationController
	def show
		sponsor_id = params[:id]
		@sponsor = User.find_by_id(sponsor_id)
		@prizes = @sponsor.prizes
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
