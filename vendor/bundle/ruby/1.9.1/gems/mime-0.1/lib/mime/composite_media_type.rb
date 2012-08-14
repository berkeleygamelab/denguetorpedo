module MIME

  #
  # Composite entities are handled using MIME mechanisms. A MIME processor must
  # handle the body directly. A CompositeMediaType object is composed of one or
  # more CompositeMediaType and/or DiscreteMediaType objects.
  #
  # This class is abstract.
  #
  class CompositeMediaType < MediaType

    def initialize content_type
      AbstractClassError.no_instantiation(self, CompositeMediaType)

      super(nil, content_type)
      @entities = Array.new
    end

    #
    # Add a MediaType object to the message.
    #
    def add_entity entity
      raise Error.new('can only add MediaType objects')  unless entity.is_a? MediaType
      @entities.unshift(entity)
    end

    #
    # Attach a MediaType object to the message.
    #
    def attach_entity entity, params = {}
      entity.set_content_disposition('attachment', params)
      add_entity(entity)
    end

    #
    # Inline a MediaType object in the message.
    #
    def inline_entity entity, params = {}
      entity.set_content_disposition('inline', params)
      add_entity(entity)
    end

  end

  #
  # MessageMedia is intended to encapsulate another message. In particular,
  # the <em>message/rfc822</em> content type is used to encapsulate RFC 822
  # messages.
  #
  # TODO Implement
  #
  class MessageMedia < CompositeMediaType
  end

  #
  # The abstract base class for all multipart message subtypes. The entities of
  # a multipart message are delimited by a unique boundary.
  #
  class MultipartMedia < CompositeMediaType

    def initialize content_type
      AbstractClassError.no_instantiation(self, MultipartMedia)
      super
    end

    #
    # The boundary used to separate the message entities.
    #
    def boundary
      @boundary ||= "Boundary_#{unique_id}"
    end

    #
    # Return the multipart representation of the body.
    #
    def body
      all_entities = @entities.join("\r\n--#{boundary}\r\n")
      "--#{boundary}\r\n#{all_entities}\r\n--#{boundary}--\r\n"
    end

  end

  #
  # The Alternative subtype indicates that each contained entity is an
  # alternatively formatted version of the same content. The most complex
  # version should be added to the message first, i.e. it will be sequentially
  # last in the message.
  #
  class MultipartMedia::Alternative < MultipartMedia

    #
    # Returns a MultipartMedia::Alternative object with a content type of
    # multipart/alternative.
    #
    def initialize
      super("multipart/alternative; boundary=#{boundary}")
    end

  end

  #
  # The FormData subtype expresses values for HTML form data submissions.
  # ---
  # RFCs consulted during implementation:
  #
  # * RFC-1867  Form-based File Upload in HTML
  # * RFC-2388  Returning Values from Forms: multipart/form-data
  #
  class MultipartMedia::FormData < MultipartMedia

    #
    # Returns a MultipartMedia::FormData object with a content type of
    # multipart/form-data.
    #
    def initialize
      super("multipart/form-data; boundary=#{boundary}")
    end

    #
    # Add the MediaType object, +entity+, to the FormData object. +name+ is
    # typically an HTML input tag variable name. If the input tag is of type
    # _file_, then +filename+ must be specified to indicate a file upload.
    #
    def add_entity entity, name, filename = nil
      entity.set_content_disposition('form-data', 'name' => name, 'filename' => filename)
      super(entity)
    end

  end

  #
  # The Mixed subtype aggregates contextually independent entities.
  #
  class MultipartMedia::Mixed < MultipartMedia

    #
    # Returns a MultipartMedia::Mixed object with a content type of
    # multipart/mixed.
    #
    def initialize
      super("multipart/mixed; boundary=#{boundary}")
    end

  end

  #
  # The Related subtype aggregates multiple related entities. The message
  # consists of a root (the first entity) which references subsequent inline
  # entities. Message entities should be referenced by their Content-ID header.
  # The syntax of a reference is unspecified and is instead dictated by the
  # encoding or protocol used in the entity.
  # ---
  # RFC consulted during implementation:
  # 
  # * RFC-2387  The MIME Multipart/Related Content-type
  #
  class MultipartMedia::Related < MultipartMedia

    #
    # Returns a MultipartMedia::Related object with a content type of
    # multipart/related.
    #
    def initialize
      super("multipart/related; boundary=#{boundary}")
    end

  end

end
