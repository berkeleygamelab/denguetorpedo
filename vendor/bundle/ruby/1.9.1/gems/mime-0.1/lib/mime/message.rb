require 'time'
require 'mime/headers/internet'
require 'mime/headers/mime'


module MIME

  #
  # Construct textual messages using the RFC 2822 Internet message format.
  #
  class Message

    include Headers::Internet
    include Headers::MIME

    # HeaderContainer access
    attr_reader :headers

    attr_accessor :body

    #
    # Return a Message object with body optionally set to +body+.
    #
    def initialize body = nil
      @body = body
      @headers = HeaderContainer.new
      self.date = Time.now.rfc2822
      self.message_id = "#{rand(1E9)}@#{__id__.abs}"
      self.mime_version = "1.0 (Ruby MIME v#{VERSION})"
    end

    #
    # Return the Internet message formatted representation of the instance.
    #
    def to_s
      #--
      # In an RFC 2822 message, the header and body sections must be separated
      # by two line breaks (CRLF). One line break is deliberately missing,
      # allowing a body supplier to append headers to the top-level message
      # header section. Consequently, the body supplier is responsible for
      # handling the body-header separation. Furthermore, if the +body+ is
      # empty, the header section will be properly terminated, creating a
      # standards compliant message.
      #++

      "#{headers}\r\n#{body}\r\n"
    end

  end

end
