module ApplicationHelper
  
  def self.temp_password_generator
    char_bank = (('a'..'z').to_a + ('0'..'9').to_a + ('A'..'Z').to_a) - %w(i o 0 1 l 0)
    char_bank.shuffle.shuffle.shuffle!
    (1..8).collect{|a| char_bank[rand(char_bank.size)] }.join
  end
    
end
