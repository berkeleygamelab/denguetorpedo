module HomeHelper
  
  def is_hilited_neighborhood? (selected_neighborhood, neighborhood) 
    (selected_neighborhood == neighborhood) ? "hilite" : ""
  end

end