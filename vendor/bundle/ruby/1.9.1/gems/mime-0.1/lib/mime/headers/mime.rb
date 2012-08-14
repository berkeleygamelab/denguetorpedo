module MIME
  module Headers

    #
    # The RFC 2045 MIME message header fields.
    #
    module MIME

      attr_reader :mime_version,
        :content_description,
        :content_disposition,
        :content_id,
        :content_transfer_encoding,
        :content_type


      #
      # Describes the content, which can be useful for non-MIME clients.
      #
      def content_description= description
        @content_description = description
        headers.add('Content-Description', description)
      end

      #
      # Specifies the disposition of the content relative to its enclosing
      # message. Valid values for +disposition+ are _inline_ and _attachment_.
      # Parameters can also be specified here; see the RFC for details.
      #
      # RFC 2183 Communicating Presentation Information in Internet Messages.
      #
      def content_disposition= disposition
        @content_disposition = disposition
        headers.add('Content-Disposition', disposition)
      end

      #
      # Globally unique ID that identifies a top-level message or message
      # entity. Content IDs can be used for referencing or caching purposes.
      #
      def content_id= id
        @content_id = id
        headers.add('Content-ID', "<#{id}>")
      end

      #
      # The mechanism used for encoding the top-level message content.
      #
      # Common Encoding Mechanisms
      # 1. 7bit
      # 2. 8bit
      # 3. binary
      # 4. quoted-printable
      # 5. base64
      #
      def content_transfer_encoding= encoding
        @content_transfer_encoding = encoding
        headers.add('Content-Transfer-Encoding', encoding)
      end

      #
      # Specifies the media type and subtype of the content. +type+ will have
      # the form <em>media-type/subtype</em>.
      #
      # Common Content Types
      # 1. application/octet-stream
      # 2. audio/mpeg
      # 3. image/jpeg
      # 4. text/plain
      # 5. video/mpeg
      #
      def content_type= type
        @content_type = type
        headers.add('Content-Type', type)
      end

      #
      # Currently only version 1.0 exists.
      #
      def mime_version= version
        @mime_version = version
        headers.add('MIME-Version', version)
      end

      protected

      #
      # +type+ is the disposition type of either "inline" or "attachment".
      # +params+ is a Hash with zero or more of the following keys:
      #
      #   * filename          => name of file
      #   * creation-date     => RFC2822 data-time
      #   * modification-date => RFC2822 data-time 
      #   * read-date         => RFC2822 data-time
      #   * size              => file size in octets
      #
      # The values for the *-date keys may use Time::rfc2822.
      #
      def set_content_disposition type, params = {}
        disposition = type

        if params['filename']
          params['filename'] = File.basename(params['filename'])
        elsif self.respond_to?(:path)
          params['filename'] = File.basename(self.path)
        end

        params.each do |name, value|
          disposition << %Q[; #{name}="#{value}"]  if value
        end

        self.content_disposition = disposition
      end

    end

  end
end
