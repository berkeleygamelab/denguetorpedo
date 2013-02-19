class RewardsController < ApplicationController
  def index
    @random_sponsors = []
    5.times do
      @random_sponsors.push('home_images/sponsor'+(rand(5)+1).to_s+'.png')
    end
  end
end
