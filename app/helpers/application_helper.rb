module ApplicationHelper
  
  def self.temp_password_generator
    char_bank = ('0'..'9').to_a
    char_bank.shuffle.shuffle.shuffle!
    (1..8).collect{|a| char_bank[rand(char_bank.size)] }.join
  end
    
  def highlight_active_link(path)
    "current_link" if current_page?(path)
  end 
 
end
