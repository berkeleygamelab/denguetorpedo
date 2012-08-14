module MIME

  #
  # Storage for RFC 2822 headers.
  #
  class HeaderContainer

    #
    # Return a new header container object.
    #
    def initialize
      @headers = Hash.new
    end

    #
    # Convert all headers to their string equivalents and join them using the
    # RFC 2822 CRLF line separator.
    #
    def to_s
      @headers.collect do |name, value|
        "#{name}: #{value}"
      end.join("\r\n")
    end

    #
    # Add the +name+/+value+ pair to the header container.
    #
    def add name, value
      @headers.store(name, value)
    end

  end

end
