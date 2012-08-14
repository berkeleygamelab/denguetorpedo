module MIME

  #
  # Discrete media types must be handled by non-MIME mechanisms; they are
  # opaque to MIME processors. Therefore, the body of a DiscreteMediaType
  # object does not need further MIME processing.
  #
  # This class is abstract.
  #
  class DiscreteMediaType < MediaType

    def initialize body, content_type = 'application/octet-stream'
      AbstractClassError.no_instantiation(self, DiscreteMediaType)
      super
    end

  end

  #
  # ApplicationMedia is intended for discrete data that is to be processed by
  # some type of application program. The body contains information which must
  # be processed by an application before it is viewable or usable by a user.
  #
  # ApplicationMedia is the catch all class. If your content cannot be
  # identified as another DiscreteMediaType, then it is application media.
  #
  # See DiscreteMediaType.new for initialization parameters.
  #
  class ApplicationMedia < DiscreteMediaType
  end

  #
  # AudioMedia is intended for discrete audio content. The content subtype
  # indicates the specific audio format.
  #
  # See DiscreteMediaType.new for initialization parameters.
  #
  class AudioMedia < DiscreteMediaType
  end

  #
  # ImageMedia is intented for discrete image content. The content subtype
  # indicates the specific image format.
  #
  # See DiscreteMediaType.new for initialization parameters.
  #
  class ImageMedia < DiscreteMediaType
  end

  #
  # TextMedia is intended for content which is principally textual in form.  
  #
  class TextMedia < DiscreteMediaType
    
    #
    # Return a new TextMedia object containing +body+ with the content type of
    # +content_type+.
    #
    # To specify the character set of +body+, a _charset_ parameter may be
    # appended to +content_type+ using a semi-colon delimiter.
    #
    def initialize body, content_type = 'text/plain; charset=us-ascii'
      super
    end

  end

  #
  # VideoMedia is intended for discrete video content. The content subtype
  # indicates the specific video format. The RFC describes video media as
  # content that contains a time-varying-picture image, possibly with color and
  # coordinated sound.
  #
  # See DiscreteMediaType.new for initialization parameters.
  #
  class VideoMedia < DiscreteMediaType
  end

end
