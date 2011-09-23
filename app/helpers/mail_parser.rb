module MailParser
  class Parser
    
    attr_reader :report, :nation, :city, :address, :neighborhood, :state
    
    def initialize(input, type = 'email')
      if (type == 'emiail')
        text_body = MMS2R::Media.new(input).body
      elsif (type == 'sms')
        text_body = input
      end
      @report = parse('report', text_body)
      @nation = parse('nation', text_body)
      @city = parse('city', text_body)
      @address = parse('address', text_body)
      @neighborhood = parse('neighborhood', text_body)
      @state = parse('state', text_body)
    end
  
    private
  
    def parse(hashtag, text_body)
      case hashtag
        when 'report'
          result = /(?:#report|#r) ([^#]+)/i.match(text_body)
        when 'nation'
          result = /(?:#nation|#n) ([^#]+)/i.match(text_body)
        when 'city'
          result = /(?:#city|#c) ([^#]+)/i.match(text_body)
        when 'address'
          result = /(?:#address|#a) ([^#]+)/i.match(text_body)
        when 'neighborhood'
          result = /(?:#neighborhood|#h) ([^#]+)/i.match(text_body)
          if result.nil?
            result = ""
          end
        when 'state'
          result = /(?:#state|#s) ([^#]+)/i.match(text_body)
        else 
          result = nil
        end
      result ? result[1].strip.gsub(/\n/," ") : result
    end
  end
  
end