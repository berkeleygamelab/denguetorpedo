module HomeHelper
  
  def is_hilited (selected_neighborhood, neighborhood) 
    (selected_neighborhood == neighborhood) ? "hilite" : ""
  end

end
