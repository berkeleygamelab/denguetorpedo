require 'mime/error'
require 'mime/header_container'
require 'mime/headers/mime'

module MIME

  #
  # Abstract top-level media type class.
  #
  class MediaType

    include Headers::MIME

    attr_reader :headers
    attr_accessor :body
    protected :body, :body=

    def initialize body, content_type
      AbstractClassError.no_instantiation(self, MediaType)

      @headers = HeaderContainer.new
      @body = body
      self.content_id = unique_id
      self.content_type = content_type
    end

    #
    # Transform the the MediaType object into a MIME message.
    #
    def to_s
      "#{headers}\r\n\r\n#{body}"
    end

    private

    #
    # Generate a globally unique identifier for use in boundaries and IDs.
    #
    def unique_id
      "#{object_id.abs}#{rand}"
    end

  end

end
