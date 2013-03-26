module ReportsHelper
  def random_sponsors
    random_sponsors = []
    9.times do
      random_sponsors.push('home_images/sponsor'+(rand(5)+1).to_s+'.png')
    end 
    random_sponsors   
  end
  
end